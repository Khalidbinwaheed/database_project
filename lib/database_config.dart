import 'package:mysql1/mysql1.dart';

class DatabaseConfig {
  static final DatabaseConfig _instance = DatabaseConfig._internal();
  static MySqlConnection? _connection;
  
  factory DatabaseConfig() {
    return _instance;
  }
  
  DatabaseConfig._internal();

  Future<MySqlConnection> getConnection() async {
    if (_connection != null) {
      try {
        // Test connection with a simple query instead of ping
        await _connection!.query('SELECT 1');
        return _connection!;
      } catch (e) {
        await _connection!.close();
        _connection = null;
      }
    }

    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '',
      db: 'blood_donation_db',
      timeout: Duration(seconds: 30),
    );

    try {
      _connection = await MySqlConnection.connect(settings);
      print('Database connected successfully');
      return _connection!;
    } catch (e) {
      print('Error connecting to MySQL database: $e');
      rethrow;
    }
  }

  Future<void> closeConnection() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }
  }

  // Create tables if they don't exist
  Future<void> initializeDatabase() async {
    final conn = await getConnection();
    try {
      // Create donors table
      await conn.query('''
        CREATE TABLE IF NOT EXISTS donors (
          id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(100) NOT NULL,
          blood_type VARCHAR(5) NOT NULL,
          phone VARCHAR(15) NOT NULL,
          email VARCHAR(100),
          address TEXT,
          last_donation_date DATE,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Create blood_requests table
      await conn.query('''
        CREATE TABLE IF NOT EXISTS blood_requests (
          id INT AUTO_INCREMENT PRIMARY KEY,
          patient_name VARCHAR(100) NOT NULL,
          blood_type VARCHAR(5) NOT NULL,
          units_needed INT NOT NULL,
          hospital VARCHAR(100) NOT NULL,
          contact_phone VARCHAR(15) NOT NULL,
          urgency_level VARCHAR(20) NOT NULL,
          status VARCHAR(20) DEFAULT 'pending',
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      print('Database tables initialized successfully');
    } catch (e) {
      print('Error initializing database tables: $e');
      rethrow;
    }
  }

  // Helper method to execute queries with automatic connection management
  Future<Results> executeQuery(String query, [List<dynamic>? params]) async {
    final conn = await getConnection();
    try {
      final results = await conn.query(query, params);
      return results;
    } catch (e) {
      print('Error executing query: $e');
      rethrow;
    }
  }

  // Insert donor
  Future<int> insertDonor(Map<String, dynamic> donor) async {
    final results = await executeQuery(
      'INSERT INTO donors (name, blood_type, phone, email, address) VALUES (?, ?, ?, ?, ?)',
      [donor['name'], donor['blood_type'], donor['phone'], donor['email'], donor['address']]
    );
    return results.insertId!;
  }

  // Get all donors
  Future<List<Map<String, dynamic>>> getDonors() async {
    final results = await executeQuery('SELECT * FROM donors ORDER BY created_at DESC');
    return results.map((row) => row.fields).toList();
  }

  // Insert blood request
  Future<int> insertBloodRequest(Map<String, dynamic> request) async {
    final results = await executeQuery(
      'INSERT INTO blood_requests (patient_name, blood_type, units_needed, hospital, contact_phone, urgency_level) VALUES (?, ?, ?, ?, ?, ?)',
      [request['patient_name'], request['blood_type'], request['units_needed'], request['hospital'], request['contact_phone'], request['urgency_level']]
    );
    return results.insertId!;
  }

  // Get all blood requests
  Future<List<Map<String, dynamic>>> getBloodRequests() async {
    final results = await executeQuery('SELECT * FROM blood_requests ORDER BY created_at DESC');
    return results.map((row) => row.fields).toList();
  }
}

// Example of how to use the DatabaseConfig class:
/*
void main() async {
  final dbConfig = DatabaseConfig();
  
  // Test the connection
  bool isConnected = await dbConfig.testConnection();
  if (!isConnected) {
    print('Failed to connect to database');
    return;
  }

  try {
    // Example query
    var results = await dbConfig.executeQuery(
      'SELECT * FROM users WHERE name = ?',
      ['John']
    );
    
    for (var row in results) {
      print('User: ${row['name']}');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    // Always close the connection when done
    await dbConfig.closeConnection();
  }
}
*/