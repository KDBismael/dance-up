import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class OverlappingAvatars extends StatelessWidget {
  final List<String> imageUrls;
  final int extraCount;
  final double radius;
  final double overlapSpacing;

  const OverlappingAvatars({
    super.key,
    required this.imageUrls,
    required this.extraCount,
    this.radius = 24,
    this.overlapSpacing = 24,
  });

  @override
  Widget build(BuildContext context) {
    final totalCount = imageUrls.length + (extraCount > 0 ? 1 : 0);
    final totalWidth = (totalCount - 1) * overlapSpacing + radius * 2;

    return SizedBox(
      width: totalWidth,
      height: radius * 2,
      child: Stack(
        children: [
          for (int i = 0; i < imageUrls.length; i++)
            Positioned(
              left: i * overlapSpacing,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: radius - 2,
                  backgroundImage: NetworkImage(imageUrls[i]),
                ),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: imageUrls.length * overlapSpacing,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: radius - 2,
                  backgroundColor: AppColors.secondary,
                  child: Text(
                    '+$extraCount',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
