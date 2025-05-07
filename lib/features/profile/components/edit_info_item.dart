import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class EditInfoItem extends StatelessWidget {
  const EditInfoItem({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
  });
  final Function()? onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.blackGray)),
              Text(subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.black))
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          )
        ],
      ),
    );
  }
}
