import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/sub_profile_button.dart';
import 'package:dance_up/features/profile/components/sub_profile_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyControls extends StatelessWidget {
  PrivacyControls({super.key});
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return BaseProfileSubPage(
      appBarTitle: "Privacy Controls",
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SubProfileButton(
              title: "Profile Visibility",
              subtitle: "Set you profile visibility",
              onTap: () {
                showCustomModalBottomSheet(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (true)
                              const Icon(Icons.check, color: AppColors.accent),
                            if (false) const SizedBox(width: 22),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: "Public",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.black),
                                  children: [
                                    TextSpan(
                                      text: " (everyone)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.blackGray),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            if (false)
                              const Icon(Icons.check, color: AppColors.accent),
                            if (true) const SizedBox(width: 22),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: "Private",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.black),
                                  children: [
                                    TextSpan(
                                      text: " (only you)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.blackGray),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            if (false)
                              const Icon(Icons.check, color: AppColors.accent),
                            if (true) const SizedBox(width: 22),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: "Dance Partners",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.black),
                                  children: [
                                    TextSpan(
                                      text: " (only dance partners)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.blackGray),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Obx(
              () => SubProfileSwitchButton(
                title: "Open for Messaging",
                subtitle:
                    "Let others know if you're online and want to receive message",
                value: authPresenter.user.value!.isOnline ?? false,
                onChanged: (value) {
                  authPresenter.updateProfile({'isOnline': value});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
