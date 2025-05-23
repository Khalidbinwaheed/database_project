import 'package:flutter/material.dart';
import 'package:database_project/myrequest.dart'; // Make sure this file exists and is correct

class DonationRequestPage extends StatelessWidget {
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  DonationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Create Donation Request',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Help someone in need',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Select Blood Type Needed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  bloodTypes
                      .map(
                        (type) => ChoiceChip(
                          label: Text(type),
                          selected: false,
                          onSelected: (_) {},
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Request Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.local_hospital, color: Colors.red),
                hintText: 'Hospital Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                hintText: 'Location',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.note, color: Colors.red),
                hintText: 'Additional Notes',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MyRequestScreen(
                              bloodType: 'A+',
                              hospitalName: 'City Hospital',
                              location: 'Downtown',
                              notes: 'Urgent need for surgery',
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Submit Donation Request"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
