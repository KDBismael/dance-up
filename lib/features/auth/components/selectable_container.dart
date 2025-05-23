import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectableContainer extends StatelessWidget {
  const SelectableContainer({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onSelect,
  });
  final String text;
  final void Function(String)? onSelect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onSelect != null) onSelect!(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.accent.withOpacity(0.8) : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.gray,
            width: 1,
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.black,
              ),
        ),
      ),
    );
  }
}
