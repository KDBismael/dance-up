import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class FollowerUsersCard extends StatelessWidget {
  const FollowerUsersCard({
    super.key,
    required this.userName,
    required this.fullName,
    required this.imageLink,
    required this.buttonText,
    this.onButtonPressed,
    this.buttonColor = AppColors.red,
    this.onProfileTapped,
  });

  final String userName;
  final String fullName;
  final String imageLink;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Color buttonColor;
  final VoidCallback? onProfileTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onProfileTapped,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageLink),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fullName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.black)),
                  Text(
                    "@$userName",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColors.blackGray),
                  ),
                ],
              )
            ],
          ),
        ),
        OutlinedButton(
          onPressed: onButtonPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: buttonColor,
            side: BorderSide.none,
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 8.5),
          ),
          child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.white),
          ),
        )
      ],
    );
  }
}
