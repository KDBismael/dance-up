import 'package:dance_up/app.dart';
import 'package:dance_up/features/auth/onboarding/macth_vibes_screen.dart';
import 'package:flutter/material.dart';

class DiscoverDanceEventsScreen extends StatefulWidget {
  const DiscoverDanceEventsScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverDanceEventsScreen> createState() =>
      _DiscoverDanceEventsScreenState();
}

class _DiscoverDanceEventsScreenState extends State<DiscoverDanceEventsScreen> {
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
                  'res/images/discoverDanceEvents.png',
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
                      "Discover Dance Events",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Stay updated on the hottest dance events in your city and never miss a chance to groove!",
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
                                  builder: (context) =>
                                      const MatchVibesScreen(),
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.5)),
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
                              "Skip",
                              style: TextStyle(color: Colors.black),
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
