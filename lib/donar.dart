import 'package:flutter/material.dart';

class FindDonorsPage extends StatelessWidget {
  const FindDonorsPage({super.key});

  // Blood compatibility map (who can receive from whom)
  Map<String, List<String>> getCompatibilityMap() {
    return {
      'A+': ['A+', 'AB+'],
      'A-': ['A+', 'A-', 'AB+', 'AB-'],
      'B+': ['B+', 'AB+'],
      'B-': ['B+', 'B-', 'AB+', 'AB-'],
      'AB+': ['AB+'],
      'AB-': ['AB+', 'AB-'],
      'O+': ['O+', 'A+', 'B+', 'AB+'],
      'O-': ['O-', 'O+', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'], // universal
    };
  }

  // Dialog to show compatible recipients with a dropdown selection
  void showCompatibleRecipients(BuildContext context, String donorType) {
    final compatibility = getCompatibilityMap();
    final recipients = compatibility[donorType] ?? [];
    String? selectedRecipient;

    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Compatible Recipients for $donorType'),
                content:
                    recipients.isEmpty
                        ? const Text('No data available.')
                        : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Select a recipient blood type:'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: selectedRecipient,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Recipient Blood Type',
                              ),
                              items:
                                  recipients
                                      .map(
                                        (type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(type),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedRecipient = value;
                                });
                              },
                            ),
                          ],
                        ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                  if (selectedRecipient != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You selected $selectedRecipient as recipient.',
                            ),
                          ),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                ],
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: const Text('Find Donors', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.red.shade400,
            width: double.infinity,
            child: const Text(
              'Search for blood donors in your area',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  bloodTypes.map((type) {
                    return ElevatedButton(
                      onPressed: () => showCompatibleRecipients(context, type),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(type),
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
                labelText: 'Select Location',
              ),
              items: const [
                DropdownMenuItem(value: 'New York', child: Text('New York')),
                DropdownMenuItem(
                  value: 'Los Angeles',
                  child: Text('Los Angeles'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: const [
                DonorCard(
                  name: 'John Doe',
                  bloodType: 'A+',
                  location: 'New York',
                  lastDonated: '2 weeks ago',
                  isAvailable: true,
                ),
                DonorCard(
                  name: 'Jane Smith',
                  bloodType: 'B+',
                  location: 'Los Angeles',
                  lastDonated: '1 month ago',
                  isAvailable: false,
                ),
                DonorCard(
                  name: 'Alice Johnson',
                  bloodType: 'O+',
                  location: 'New York',
                  lastDonated: '3 weeks ago',
                  isAvailable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DonorCard extends StatelessWidget {
  final String name;
  final String bloodType;
  final String location;
  final String lastDonated;
  final bool isAvailable;

  const DonorCard({
    super.key,
    required this.name,
    required this.bloodType,
    required this.location,
    required this.lastDonated,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isAvailable ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isAvailable ? 'Available' : 'Not Available',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.bloodtype, size: 18, color: Colors.red),
                const SizedBox(width: 4),
                Text(bloodType),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location),
              ],
            ),
            const SizedBox(height: 8),
            Text('Last Donated: $lastDonated'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isAvailable ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text('Contact Donor'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
