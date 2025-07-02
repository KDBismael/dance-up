import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.isSelected,
    required this.tag,
  });

  final bool isSelected;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13.5, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.blackGray,
        ),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isSelected ? Colors.white : AppColors.blackGray,
            ),
      ),
    );
  }
}
