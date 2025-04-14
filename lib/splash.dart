import 'package:dance_up/app.dart';
import 'package:dance_up/core/services/get_storage.dart';
import 'package:dance_up/features/auth/onboarding/meet_dancers_screnn.dart';
import 'package:dance_up/features/auth/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _handleAppStart(); // just trigger the check when screen is built

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Dance Up",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
        // child: Image.asset(
        //   'assets/logo.png', // your app logo here
        //   width: 150,
        //   height: 150,
        // ),
      ),
    );
  }

  void _handleAppStart() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate logo splash

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
}
