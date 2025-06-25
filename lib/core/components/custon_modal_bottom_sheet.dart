import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? gradientStopEnd,
  Color? gradientColor,
}) {
  return showModalBottomSheet<T>(
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    barrierColor: const Color(0xFFD9D9D9).withOpacity(0.5),
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: gradientStopEnd != null && gradientColor != null
            ? BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, gradientStopEnd],
                  colors: [gradientColor, Colors.white],
                ),
              )
            : const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 3,
              width: 41,
              color: const Color(0xFFE0DFE2),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(child: child),
              ),
            ),
          ],
        ),
      );
    },
  );
}
