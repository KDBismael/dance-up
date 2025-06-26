import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/navigation/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNaBar extends StatelessWidget {
  const BottomNaBar({super.key});

  @override
  Widget build(Object context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: AppColors.white,
          indicatorColor: AppColors.accent,
          selectedIndex: NavigationController.to.currentIndex.value,
          onDestinationSelected: (value) =>
              NavigationController.to.changeIndex(value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.event_outlined),
              selectedIcon: Icon(Icons.event, color: AppColors.white),
              label: 'Events',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
