import 'package:flutter/material.dart';

class CenterDetailsPage extends StatelessWidget {
  final List<Map<String, String>> centers = [
    {
      'name': 'Red Cross Blood Center',
      'location': 'Downtown - 3.2 km away',
      'address': '123 Main Street, Downtown',
    },
    {
      'name': 'City Hospital Blood Bank',
      'location': 'West Side - 4.5 km away',
      'address': '456 Elm Avenue, West Side',
    },
    {
      'name': 'Life Saver Center',
      'location': 'North End - 2.8 km away',
      'address': '789 Pine Lane, North End',
    },
  ];

  CenterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Blood Centers'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: centers.length,
        itemBuilder: (context, index) {
          final center = centers[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(
                Icons.local_hospital,
                color: Colors.red,
                size: 32,
              ),
              title: Text(
                center['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    center['location']!,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Text(
                    center['address']!,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.navigation_outlined, color: Colors.red),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening ${center['name']} location...'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
