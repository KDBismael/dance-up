import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/core/theme/colors.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
            // const SizedBox(height: 24),
            const Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColors.red,
                  ),
                ),
              ],
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "${authPresenter.user.value?.firstName} ${authPresenter.user.value?.lastName}",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: AppColors.black)),
                  // const SizedBox(height: 4),
                  Text(
                    "${authPresenter.user.value?.bio ?? 'No bio'}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColors.blackGray),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 61,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FollowerButton(
                            count: "5",
                            title: "Partners",
                            onTap: () {
                              Get.toNamed(Routes.partnersScreen);
                            },
                          ),
                        ),
                        const VerticalDivider(
                          width: 24,
                          color: Color(0xFFD9D9D9),
                          thickness: 1,
                          indent: 8,
                          endIndent: 0,
                        ),
                        Expanded(
                          child: FollowerButton(
                            count: "160k",
                            title: "Followers",
                            onTap: () {
                              Get.toNamed(Routes.followersScreen);
                            },
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0xFFD9D9D9),
                          width: 24,
                          thickness: 1,
                          indent: 8,
                          endIndent: 0,
                        ),
                        Expanded(
                          child: FollowerButton(
                            count: "10",
                            title: "Following",
                            onTap: () {
                              Get.toNamed(Routes.followingsScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 13),
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
                  ProfileItem(
                    onTap: () {
                      Get.toNamed(Routes.privacyControls);
                    },
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

class FollowerButton extends StatelessWidget {
  const FollowerButton({
    required this.count,
    this.onTap,
    required this.title,
    super.key,
  });

  final String count;
  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            count,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.black),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.blackGray),
          )
        ],
      ),
    );
  }
}
