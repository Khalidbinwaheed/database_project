import 'package:flutter/material.dart';

class MyRequestScreen extends StatelessWidget {
  final String bloodType;
  final String hospitalName;
  final String location;
  final String notes;

  const MyRequestScreen({
    super.key,
    required this.bloodType,
    required this.hospitalName,
    required this.location,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Request Details'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Blood Type: $bloodType',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Hospital Name: $hospitalName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Notes: $notes', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
