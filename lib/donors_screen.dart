import 'package:flutter/material.dart';
import 'database_config.dart';

class DonorsScreen extends StatefulWidget {
  const DonorsScreen({super.key});

  @override
  State<DonorsScreen> createState() => _DonorsScreenState();
}

class _DonorsScreenState extends State<DonorsScreen> {
  final DatabaseConfig _dbConfig = DatabaseConfig();
  List<Map<String, dynamic>> _donors = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }

  Future<void> _loadDonors() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final donors = await _dbConfig.getDonors();
      
      setState(() {
        _donors = donors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading donors: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _addDonor() async {
    try {
      final donorData = {
        'name': 'New Donor',
        'blood_type': 'A+',
        'phone': '1234567890',
        'email': 'donor@example.com',
        'address': '123 Street'
      };

      await _dbConfig.insertDonor(donorData);
      _loadDonors(); // Reload the list after adding
    } catch (e) {
      setState(() {
        _error = 'Error adding donor: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDonors,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadDonors,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _donors.isEmpty
                  ? const Center(child: Text('No donors found'))
                  : ListView.builder(
                      itemCount: _donors.length,
                      itemBuilder: (context, index) {
                        final donor = _donors[index];
                        return ListTile(
                          title: Text(donor['name'] ?? 'Unknown'),
                          subtitle: Text('Blood Type: ${donor['blood_type']}'),
                          trailing: Text(donor['phone'] ?? ''),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDonor,
        child: const Icon(Icons.add),
      ),
    );
  }
} 