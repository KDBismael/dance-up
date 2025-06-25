import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GuestProfile extends StatelessWidget {
  GuestProfile({super.key});
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return BaseWidgetWithGradient(
      gradientColor: const Color(0xFFDAC04D),
      children: [
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
                        "KDB Ismael ${authPresenter.user.value?.username ?? ''}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: AppColors.black)),
                    // const SizedBox(height: 4),
                    Text(
                      "No bio",
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
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            // backgroundColor: AppColors.red,
                            side: BorderSide.none,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.5, horizontal: 8.5),
                          ),
                          child: Text(
                            "Follow",
                            // "Unfollow",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                        ),
                        // const SizedBox(width: 10),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            showCustomModalBottomSheet(
                              context: context,
                              child: SendPartnerRequestModal(
                                  authPresenter: authPresenter),
                            );
                            // showCustomModalBottomSheet(
                            //   context: context,
                            //   child: RemoveOrCancelRequestModal(
                            //     authPresenter: authPresenter,
                            //     title: 'Cancel partner request to Jaydon',
                            //     btnText: "wait for response",
                            //     subtitle:
                            //         'Are you sure you want to cancel your partner request sended ?',
                            //     onPressed: () {},
                            //   ),
                            // );
                            // showCustomModalBottomSheet(
                            //   context: context,
                            //   child: RemoveOrCancelRequestModal(
                            //     authPresenter: authPresenter,
                            //     title: 'Remove partnership with Jaydon',
                            //     btnText: "Cancel",
                            //     subtitle:
                            //         'Are you sure you want to remove your partnership with Jaydon ?',
                            //     onPressed: () {},
                            //   ),
                            // );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            side: BorderSide.none,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.5, horizontal: 8.5),
                          ),
                          child: Text(
                            "Send Partner Request",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.liteYellow),
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send_outlined,
                            color: AppColors.accent,
                            size: 18,
                          ),
                          style: TextButton.styleFrom(
                            side: BorderSide.none,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.5, horizontal: 8.5),
                          ),
                          label: Text(
                            'Share',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.accent),
                          ),
                          iconAlignment: IconAlignment.start,
                        ),
                      ],
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
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 24, left: 20, right: 20),
                // child: Text("hh"),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SendPartnerRequestModal extends StatelessWidget {
  const SendPartnerRequestModal({
    super.key,
    required this.authPresenter,
  });

  final AuthPresenter authPresenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Send partner request to KDB Ismael",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: GoogleFonts.getFont('Roboto Condensed').fontFamily,
                fontSize: 20,
                color: AppColors.black,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          "Send a partner request to dancers nearby and start planning your next dance meetup!",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.blackGray,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 31),
        TextField(
          decoration: InputDecoration(
            hintText: "Custom message (optional)",
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.blackGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.gray,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.gray,
                width: 0.5,
              ),
            ),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 22),
        Obx(
          () => CustomButton(
            text: "Submit",
            isLoading: authPresenter.isLoading.value,
            onPressed: () async {
              // await authPresenter.sendPartnerRequest();
              // Get.back();
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

class RemoveOrCancelRequestModal extends StatelessWidget {
  const RemoveOrCancelRequestModal({
    super.key,
    required this.authPresenter,
    required this.title,
    required this.subtitle,
    this.onPressed,
    required this.btnText,
  });

  final AuthPresenter authPresenter;
  final String title;
  final String subtitle;
  final String btnText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: GoogleFonts.getFont('Roboto Condensed').fontFamily,
                fontSize: 20,
                color: AppColors.black,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.blackGray,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 41),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: CustomButton(
                backgroundColor: AppColors.gray,
                textColor: AppColors.blackGray,
                text: btnText == "Cancel" ? "Remove" : "Cancel",
                isLoading: authPresenter.isLoading.value,
                onPressed: onPressed,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: CustomButton(
                text: btnText,
                isLoading: authPresenter.isLoading.value,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
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
