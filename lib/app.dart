import 'package:dance_up/core/services/get_storage.dart';
import 'package:dance_up/features/auth/onboarding/meet_dancers_screnn.dart';
import 'package:dance_up/features/auth/screens/auth.dart';
import 'package:dance_up/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DanceApp extends StatelessWidget {
  const DanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
    // return MaterialApp(
    //   title: 'Dance Up',
    //   theme: AppTheme.lightTheme,
    //   home: SplashScreen(),
    //   // home: const MeetDancersScreen(),
    //   // home: const AuthScreen(),
    //   // home: const HomePage(title: 'Dance App'),
    // );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text(
                'Welcome to Dance Up!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void handleAppStart() {
  final isSeen = box.read('onboarding_seen') ?? false;
  final user = FirebaseAuth.instance.currentUser;

  if (!isSeen) {
    Get.offAll(() => const MeetDancersScreen());
  } else if (user == null) {
    Get.offAll(() => const AuthScreen());
  } else {
    Get.offAll(() => const HomePage(title: 'Dance Up'));
  }
}
