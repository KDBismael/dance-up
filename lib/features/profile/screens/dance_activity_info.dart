import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/sub_profile_button.dart';
import 'package:dance_up/features/profile/components/sub_profile_switch_button.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DanceActivityInfo extends StatelessWidget {
  DanceActivityInfo({super.key});
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return BaseProfileSubPage(
      appBarTitle: "Dance & Activity Informations",
      child: Column(
        children: [
          const SizedBox(height: 34),
          SubProfileButton(
            title: "Favorite Dance Venues",
            subtitle: "Dance venue 1, Dance venue 2 ...",
            onTap: () {
              Get.toNamed(Routes.favoriteDanceVenue, arguments: {
                'venues': ['hey', 'hey']
              });
            },
          ),
          const SizedBox(height: 24),
          // Row(
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Event Attendance History",
          //             style: Theme.of(context).textTheme.bodyMedium),
          //         const SizedBox(width: 2),
          //         Text(
          //           "Past and upcoming events a...",
          //           style: Theme.of(context)
          //               .textTheme
          //               .labelSmall
          //               ?.copyWith(color: AppColors.blackGray),
          //         ),
          //       ],
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.arrow_forward_ios_rounded,
          //       size: 15,
          //     )
          //   ],
          // ),
          // const SizedBox(height: 24),
          Obx(
            () => SubProfileSwitchButton(
              title: "Partner Preferences",
              subtitle:
                  "Let others know if you're searching for a dance partner!",
              value: authPresenter.user.value!.isSeekingDancePartner ?? false,
              onChanged: (value) {
                authPresenter.updateProfile({'isSeekingDancePartner': value});
              },
            ),
          ),
        ],
      ),
    );
  }
}
