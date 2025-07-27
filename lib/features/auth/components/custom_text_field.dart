import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? value;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? errorText;
  final String? helperText;
  final bool? isValid;
  final bool readOnly;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    required this.isValid,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.errorText,
    this.helperText,
    this.readOnly = false,
    this.value,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    if (widget.value != null) {
      widget.controller?.text = widget.value!;
    }
  }

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
              ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    size: 20,
                    color: AppColors.blackGray,
                  )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.blackGray,
                      size: 20,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintText: widget.hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.blackGray),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.gray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.gray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 2),
        if (widget.errorText != null)
          Row(
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: AppColors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.errorText!,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.red, fontSize: 12),
              ),
            ],
          )
        else if (widget.isValid == true && widget.helperText != null)
          Row(
            children: [
              const Icon(
                Icons.done_outline_outlined,
                color: AppColors.green,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.helperText!,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.green, fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }
}
