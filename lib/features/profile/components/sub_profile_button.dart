import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SubProfileButton extends StatelessWidget {
  const SubProfileButton({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
  });
  final void Function()? onTap;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: 2),
              Text(
                subtitle,
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
    );
  }
}
