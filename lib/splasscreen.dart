import 'package:database_project/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SaveLivesScreen extends StatefulWidget {
  const SaveLivesScreen({super.key});

  @override
  State<SaveLivesScreen> createState() => _SaveLivesScreenState();
}

class _SaveLivesScreenState extends State<SaveLivesScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF5E62), Color(0xFFFF9966)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Text(
                  'Save Lives',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Donate Blood, Share Love',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 20,
                    color: Colors.white70
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                  width: isSmallScreen ? size.width * 0.7 : size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                        vertical: size.height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement sign in navigation
                  },
                  child: Text(
                    'Already have an account? Sign in',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
