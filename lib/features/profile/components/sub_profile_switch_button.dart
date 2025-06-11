import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubProfileSwitchButton extends StatelessWidget {
  const SubProfileSwitchButton({
    super.key,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.value,
  });
  final void Function(bool)? onChanged;
  final String title;
  final String subtitle;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 2),
            SizedBox(
              width: Get.width * 0.70,
              child: Text(
                subtitle,
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
        Switch(
          value: value,
          onChanged: onChanged,
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
      ],
    );
  }
}
