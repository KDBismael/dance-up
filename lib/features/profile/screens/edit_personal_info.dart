import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/constants/global_constant.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:dance_up/features/auth/sign_up_onboarding/sign_up_onboarding.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/edit_info_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPersonalInfo extends StatelessWidget {
  EditPersonalInfo({super.key});
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return BaseProfileSubPage(
      appBarTitle: "Personnal information",
      child: Obx(() {
        ;
        final bio = authPresenter.user.value!.bio;
        final firstName = authPresenter.user.value!.firstName;
        final lastName = authPresenter.user.value!.lastName;
        final userName = authPresenter.user.value!.username;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 34),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage("https://example.com/profile_image.jpg"),
                ),
              ],
            ),
            const SizedBox(height: 40),
            EditInfoItem(
              onTap: () {
                customModalBottomSheet(
                  context,
                  EditInputModalBody(
                    title: "Edit your Bio",
                    hintText: 'bio',
                    value: bio,
                    onPress: (p0) async {
                      await authPresenter.updateProfile({"bio": p0});
                    },
                  ),
                );
              },
              title: "Bio",
              subtitle: bio ?? '...',
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {
                customModalBottomSheet(
                  context,
                  EditInputModalBody(
                    title: "Edit your first name",
                    hintText: 'First name',
                    value: firstName,
                    onPress: (p0) async {
                      await authPresenter.updateProfile({"firstName": p0});
                    },
                  ),
                );
              },
              title: "First name",
              subtitle: firstName,
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {
                customModalBottomSheet(
                  context,
                  EditInputModalBody(
                    title: "Edit your last name",
                    hintText: 'last name',
                    value: lastName,
                    onPress: (p0) async {
                      await authPresenter.updateProfile({"lastName": p0});
                    },
                  ),
                );
              },
              title: "Last name",
              subtitle: lastName,
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {
                customModalBottomSheet(
                  context,
                  EditInputModalBody(
                    title: "Edit your username",
                    hintText: 'Username',
                    value: userName,
                    onPress: (p0) async {
                      await authPresenter.updateProfile({"username": p0});
                    },
                  ),
                );
              },
              title: "Username",
              subtitle: "@${userName ?? '...'}",
            ),
            const SizedBox(height: 24),
            Text("Dance level",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.blackGray)),
            const SizedBox(height: 8),
            CustomDropdown(
              dropdownItems: danceLevelList,
              hintText: "Dance level",
              onChanged: (value) async {
                await authPresenter.updateProfile({"danceLevel": value});
              },
              selectedValue: authPresenter.user.value!.danceLevel,
            ),
            const SizedBox(height: 24),
            Text(
              "Dance style",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.blackGray),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                customModalBottomSheet(
                  context,
                  DanceStyleModalSelectionBody(),
                );
              },
              child: authPresenter.user.value!.danceStyle!.isEmpty
                  ? const EditLabel(title: 'Click to choose')
                  : SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: authPresenter.user.value!.danceStyle?.length,
                        itemBuilder: (context, index) {
                          final text =
                              authPresenter.user.value!.danceStyle?[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: EditLabel(title: text ?? ''),
                          );
                        },
                      ),
                    ),
              // child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     EditLabel(title: "Style 1"),
              //     SizedBox(width: 8),
              //     EditLabel(title: "Batchatatat"),
              //   ],
              // ),
            ),
            const SizedBox(height: 24),
            Text(
              "Spoken language",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.blackGray),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                customModalBottomSheet(
                  context,
                  LanguageSelectionModalBody(),
                );
              },
              child: authPresenter.user.value!.spokenLanguages!.isEmpty
                  ? const EditLabel(
                      title: 'Click to choose',
                      textColor: AppColors.primary,
                      backgroundColor: AppColors.background,
                    )
                  : SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            authPresenter.user.value!.spokenLanguages?.length,
                        itemBuilder: (context, index) {
                          final text =
                              authPresenter.user.value!.spokenLanguages?[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: EditLabel(
                              title: text ?? '',
                              textColor: AppColors.primary,
                              backgroundColor: AppColors.background,
                            ),
                          );
                        },
                      ),
                    ),
              // child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     EditLabel(
              //       title: "English",
              //       textColor: AppColors.primary,
              //       backgroundColor: AppColors.background,
              //     ),
              //     SizedBox(width: 8),
              //     EditLabel(
              //       title: "French",
              //       textColor: AppColors.primary,
              //       backgroundColor: AppColors.background,
              //     ),
              //   ],
              // ),
            ),
          ],
        );
      }),
    );
  }

  Future<dynamic> customModalBottomSheet(BuildContext context, Widget child) {
    return showModalBottomSheet(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      barrierColor: const Color(0xFFD9D9D9).withOpacity(0.5),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 3,
              width: 41,
              color: const Color(0xFFE0DFE2),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(child: child),
            ),
          ],
        );
      },
    );
  }
}

class DanceStyleModalSelectionBody extends StatelessWidget {
  DanceStyleModalSelectionBody({
    super.key,
  });
  var selectedStyle = <String>[].obs;
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    final userSelectedStyle = authPresenter.user.value?.danceStyle ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Select Your Dance Style",
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        Text(
            "Choose your favorite dance style to connect with like-minded dancers!",
            style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 24),
        Obx(
          () {
            selectedStyle.value = userSelectedStyle;
            return DanceStyle(
              list: danceStyleList,
              styleSelectedList: selectedStyle.value,
              onChanged: (val) {
                if (selectedStyle.contains(val)) {
                  selectedStyle.remove(val);
                } else {
                  selectedStyle.add(val);
                }
              },
            );
          },
        ),
        // Row(
        //   children: [
        //     SelectableContainer(text: "style 1"),
        //     const SizedBox(width: 8),
        //     SelectableContainer(text: "style 2"),
        //   ],
        // ),
        // const SizedBox(height: 8),
        // Row(
        //   children: [
        //     SelectableContainer(text: "style 1"),
        //     const SizedBox(width: 8),
        //     SelectableContainer(text: "style 2"),
        //   ],
        // ),
        const SizedBox(height: 48),
        Obx(
          () => CustomButton(
            text: "Submit",
            isLoading: authPresenter.isLoading.value,
            onPressed: () async {
              await authPresenter
                  .updateProfile({"danceStyle": selectedStyle.value});
              Get.back();
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.blackGray),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LanguageSelectionModalBody extends StatelessWidget {
  LanguageSelectionModalBody({
    super.key,
  });

  final authPresenter = Get.find<AuthPresenter>();
  var selectedLanguage = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    final userSelectedLanguage =
        authPresenter.user.value?.spokenLanguages ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Select Your Languages",
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        Text(
            "Choose your spoken languages to Helps with international connections!",
            style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 24),
        Obx(() {
          selectedLanguage.value = userSelectedLanguage;
          return DanceStyle(
            list: spokenLanguagesList,
            styleSelectedList: selectedLanguage.value,
            onChanged: (val) {
              if (selectedLanguage.contains(val)) {
                selectedLanguage.remove(val);
              } else {
                selectedLanguage.add(val);
              }
            },
          );
        }),
        // Row(
        //   children: [
        //     SelectableContainer(text: "English"),
        //     const SizedBox(width: 8),
        //     SelectableContainer(text: "French"),
        //   ],
        // ),
        const SizedBox(height: 48),
        Obx(
          () => CustomButton(
            text: "Submit",
            isLoading: authPresenter.isLoading.value,
            onPressed: () async {
              await authPresenter
                  .updateProfile({"spokenLanguages": selectedLanguage.value});
              Get.back();
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.blackGray),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EditLabel extends StatelessWidget {
  const EditLabel({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.accent,
    this.textColor = AppColors.white,
  });
  final String title;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
      ),
    );
  }
}

class EditInputModalBody extends StatelessWidget {
  EditInputModalBody({
    super.key,
    required this.title,
    this.value,
    this.onPress,
    required this.hintText,
  });
  final String title;
  final String? value;
  final String hintText;
  final Future<void> Function(String)? onPress;

  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 11),
        CustomTextField(
          controller: controller,
          // onChanged: onChanged,
          hintText: hintText,
          isValid: true,
        ),
        const SizedBox(height: 21),
        Obx(
          () => CustomButton(
              text: "Submit",
              isLoading: authPresenter.isLoading.value,
              onPressed: () async {
                onPress != null ? await onPress!(controller.text) : null;
                Get.back();
              }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.blackGray),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
