import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:dance_up/features/auth/components/selectable_container.dart';
import 'package:dance_up/features/profile/components/edit_info_item.dart';
import 'package:flutter/material.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: Text("Personnal information",
                style: Theme.of(context).textTheme.bodyMedium),
            backgroundColor: AppColors.white,
            centerTitle: false,
            // elevation: 5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                    const EditInputModalBody(
                      title: "Edit your Bio",
                      hintText: 'bio',
                      value: "Salsa lover, dancing for 5 years!",
                    ),
                  );
                },
                title: "Bio",
                subtitle: "Salsa lover, dancing for 5 years!",
              ),
              const SizedBox(height: 24),
              EditInfoItem(
                onTap: () {
                  customModalBottomSheet(
                    context,
                    const EditInputModalBody(
                      title: "Edit your first name",
                      hintText: 'First name',
                      value: "Jaydon",
                    ),
                  );
                },
                title: "First name",
                subtitle: "Jaydon",
              ),
              const SizedBox(height: 24),
              EditInfoItem(
                onTap: () {
                  customModalBottomSheet(
                    context,
                    const EditInputModalBody(
                      title: "Edit your last name",
                      hintText: 'last name',
                      value: "Mango",
                    ),
                  );
                },
                title: "Last name",
                subtitle: "Mango",
              ),
              const SizedBox(height: 24),
              EditInfoItem(
                onTap: () {
                  customModalBottomSheet(
                    context,
                    const EditInputModalBody(
                      title: "Edit your username",
                      hintText: 'Username',
                      value: "@salsaking21",
                    ),
                  );
                },
                title: "Username",
                subtitle: "@salsaking21",
              ),
              const SizedBox(height: 24),
              Text("Dance Level",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.blackGray)),
              const SizedBox(height: 8),
              const CustomDropdown(
                dropdownItems: [
                  "Beginner",
                  "Intermediate",
                  "Advanced",
                ],
                hintText: "Dance level",
              ),
              const SizedBox(height: 24),
              Text(
                "Dance Style",
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
                    const DanceStyleModalSelectionBody(),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EditLabel(title: "Style 1"),
                    SizedBox(width: 8),
                    EditLabel(title: "Batchatatat"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Language",
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
                    const LanguageSelectionModalBody(),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EditLabel(
                      title: "English",
                      textColor: AppColors.primary,
                      backgroundColor: AppColors.background,
                    ),
                    SizedBox(width: 8),
                    EditLabel(
                      title: "French",
                      textColor: AppColors.primary,
                      backgroundColor: AppColors.background,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
              child: child,
            ),
          ],
        );
      },
    );
  }
}

class DanceStyleModalSelectionBody extends StatelessWidget {
  const DanceStyleModalSelectionBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [
            SelectableContainer(text: "style 1"),
            const SizedBox(width: 8),
            SelectableContainer(text: "style 2"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SelectableContainer(text: "style 1"),
            const SizedBox(width: 8),
            SelectableContainer(text: "style 2"),
          ],
        ),
        const SizedBox(height: 48),
        CustomButton(text: "Submit", onPressed: () {}),
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
  const LanguageSelectionModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [
            SelectableContainer(text: "English"),
            const SizedBox(width: 8),
            SelectableContainer(text: "French"),
          ],
        ),
        const SizedBox(height: 48),
        CustomButton(text: "Submit", onPressed: () {}),
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
  const EditInputModalBody({
    super.key,
    required this.title,
    this.value,
    this.onChanged,
    required this.hintText,
  });
  final String title;
  final String? value;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
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
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          hintText: hintText,
          isValid: true,
        ),
        const SizedBox(height: 21),
        CustomButton(text: "Submit", onPressed: () {}),
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
