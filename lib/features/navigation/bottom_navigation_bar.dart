import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/navigation/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNaBar extends StatelessWidget {
  const BottomNaBar({super.key});

  @override
  Widget build(Object context) {
    return Obx(
      () => NavigationBar(
        backgroundColor: AppColors.white,
        elevation: 30,
        shadowColor: AppColors.primary,
        indicatorColor: AppColors.accent,
        selectedIndex: NavigationController.to.currentIndex.value,
        onDestinationSelected: (value) =>
            NavigationController.to.changeIndex(value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppColors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
