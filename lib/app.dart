import 'package:dance_up/core/services/get_storage.dart';
import 'package:dance_up/core/theme/theme.dart';
import 'package:dance_up/dependencies.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/auth/onboarding/meet_dancers_screnn.dart';
import 'package:dance_up/features/auth/screens/auth.dart';
import 'package:dance_up/features/navigation/bottom_navigation_bar.dart';
import 'package:dance_up/features/navigation/navigation_controller.dart';
import 'package:dance_up/features/profile/screens/profile.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:dance_up/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DanceApp extends StatelessWidget {
  const DanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      getPages: getPages,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthPresenter authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNaBar(),
      body: Obx(
        () => IndexedStack(
          index: NavigationController.to.currentIndex.value,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  authPresenter.signOut();
                },
                child: const Text('Home'),
              ),
            ),
            const Profile(),
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
