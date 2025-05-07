import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
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
      body: Padding(
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
                showModalBottomSheet(
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit your Bio",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 11),
                                const CustomTextField(
                                  hintText: 'bio',
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
                                            ?.copyWith(
                                                color: AppColors.blackGray),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              },
              title: "Bio",
              subtitle: "Salsa lover, dancing for 5 years!",
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {},
              title: "First name",
              subtitle: "Jaydon",
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {},
              title: "Last name",
              subtitle: "Mango",
            ),
            const SizedBox(height: 24),
            EditInfoItem(
              onTap: () {},
              title: "Username",
              subtitle: "@salsaking21",
            ),
          ],
        ),
      ),
    );
  }
}
