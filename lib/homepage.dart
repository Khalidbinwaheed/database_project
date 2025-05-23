import 'package:database_project/centerdetail.dart';
import 'package:database_project/myrequest.dart';
import 'package:flutter/material.dart';
import 'package:database_project/request.dart';
import 'package:database_project/donar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade400, Colors.red.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome, Dear",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Let's make a difference together!",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Your Blood Saves Lives!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "Emergency Blood Requests",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text("Urgent: Blood Type A+ Needed"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Respond to Request"),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  // Find Donors
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindDonorsPage(),
                        ),
                      );
                    },
                    child: actionTile(
                      Icons.person_search,
                      "Find Donors",
                      Colors.blue,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationRequestPage(),
                        ),
                      );
                    },
                    child: actionTile(
                      Icons.add_circle,
                      "Book Request",
                      Colors.red,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
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
                    child: actionTile(
                      Icons.history,
                      "My Requests",
                      Colors.pink,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CenterDetailsPage(),
                        ),
                      );
                    },
                    child: actionTile(
                      Icons.location_on,
                      "Centers",
                      Colors.purple,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nearby Centers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text("See All")),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.red),
                title: const Text("City Hospital 1"),
                subtitle: const Text("2.1 km away · Open 24/7"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Donate Now"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget actionTile(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
