import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectableContainer extends StatelessWidget {
  SelectableContainer({
    super.key,
    required this.text,
  });
  final String text;

  var isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          isSelected.value = !isSelected.value;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 13),
          decoration: BoxDecoration(
            color: isSelected.value
                ? AppColors.accent.withOpacity(0.8)
                : AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected.value ? AppColors.accent : AppColors.gray,
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected.value ? AppColors.white : AppColors.black,
                ),
          ),
        ),
      ),
    );
  }
}
