import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DanceActivityInfo extends StatelessWidget {
  DanceActivityInfo({super.key});

  var isAgreed = false.obs;

  @override
  Widget build(BuildContext context) {
    return BaseProfileSubPage(
      appBarTitle: "Dance & Activity Informations",
      child: Column(
        children: [
          const SizedBox(height: 34),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Favorite Dance Venues",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 2),
                  Text(
                    "Dance venue 1, Dance venue 2 ...",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColors.blackGray),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Event Attendance History",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 2),
                  Text(
                    "Past and upcoming events a...",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColors.blackGray),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Partner Preferences",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 2),
                  SizedBox(
                    width: Get.width * 0.70,
                    child: Text(
                      "Let others know if you're searching for a dance partner!",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.blackGray),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Obx(
                () => Switch(
                  value: isAgreed.value,
                  onChanged: (value) {
                    isAgreed.value = value;
                  },
                  activeTrackColor: AppColors.accent,
                  inactiveThumbColor: AppColors.white,
                  inactiveTrackColor: AppColors.gray,
                  trackOutlineColor: WidgetStateProperty.resolveWith(
                    (final Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return null;
                      }
                      return AppColors.gray;
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
