import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

enum CustomButtonType { elevated, outlined, filled }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final CustomButtonType type;
  final bool isDisabled;
  final Color? disabledColor;
  final Color? disabledTextColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(vertical: 14.5),
    this.borderRadius = 30.0,
    this.type = CustomButtonType.elevated,
    this.isDisabled = false,
    this.disabledColor = AppColors.blackGray,
    this.disabledTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color effectiveBackground =
        isDisabled ? disabledColor! : (backgroundColor ?? theme.primaryColor);

    final Color effectiveTextColor =
        isDisabled ? disabledTextColor! : (textColor ?? Colors.white);

    final TextStyle effectiveTextStyle =
        (textStyle ?? theme.textTheme.bodyMedium)!
            .copyWith(color: effectiveTextColor);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    switch (type) {
      case CustomButtonType.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: shape,
            side: BorderSide(color: effectiveBackground),
            padding: padding,
          ),
          onPressed: isDisabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: effectiveTextStyle),
            ],
          ),
        );

      case CustomButtonType.filled:
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: shape,
            backgroundColor: effectiveBackground,
            padding: padding,
          ),
          onPressed: isDisabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: effectiveTextStyle),
            ],
          ),
        );

      case CustomButtonType.elevated:
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveBackground,
            shape: shape,
            padding: padding,
          ),
          onPressed: isDisabled ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: effectiveTextStyle),
            ],
          ),
        );
    }
  }
}
