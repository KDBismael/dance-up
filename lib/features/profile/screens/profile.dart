import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/profile/components/profile_item.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithGradient(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage("https://example.com/profile_image.jpg"),
                ),
                const SizedBox(width: 16),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${authPresenter.user.value?.firstName} ${authPresenter.user.value?.lastName}",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text("${authPresenter.user.value?.email}")
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Expanded(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(-4, 0),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(4, 0),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Settings",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  ProfileItem(
                    onTap: () {
                      Get.toNamed(Routes.editPersonalInfo);
                    },
                    icon: Icons.info_outline_rounded,
                    title: 'Personnal information',
                  ),
                  ProfileItem(
                    onTap: () {
                      Get.toNamed(Routes.danceActivityInfo);
                    },
                    icon: Icons.card_travel_outlined,
                    title: 'Dance & Activity Informations',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Community Settings",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  const ProfileItem(
                    icon: Icons.social_distance_outlined,
                    title: 'Social Features',
                  ),
                  const ProfileItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Controls',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Other",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  const ProfileItem(
                    icon: Icons.help_outline_rounded,
                    title: 'FAQ',
                  ),
                  const ProfileItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help Center',
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
