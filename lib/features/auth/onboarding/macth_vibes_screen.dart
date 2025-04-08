import 'package:dance_up/app.dart';
import 'package:flutter/material.dart';

class MatchVibesScreen extends StatefulWidget {
  const MatchVibesScreen({Key? key}) : super(key: key);

  @override
  State<MatchVibesScreen> createState() => _MatchVibesScreenState();
}

class _MatchVibesScreenState extends State<MatchVibesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'res/images/MatchVibes.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Bottom Panel
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Match with Your Vibe",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Set your dance style and level to find the perfect partners and events just for you!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(
                                      title: 'Flutter Demo Home Page'),
                                ),
                              );
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
