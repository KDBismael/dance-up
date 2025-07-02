import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/components/overlapping_avatar.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.timeAgo,
    required this.location,
    required this.isPaid,
    required this.onJoinPressed,
    required this.participantCount,
    required this.participantAvatars,
  });

  final String imageUrl;
  final String title;
  final String timeAgo;
  final String location;
  final bool isPaid;
  final VoidCallback onJoinPressed;
  final int participantCount;
  final List<String> participantAvatars;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.liteGray),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 196,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                imageUrl,
                height: 196,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: AppColors.blackGray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location + Paid
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      isPaid ? "Paid" : "Free",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color:
                              isPaid ? AppColors.secondary : AppColors.green),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OverlappingAvatars(
                      imageUrls: participantAvatars,
                      extraCount: participantCount,
                    ),
                    const Spacer(flex: 1),
                    Flexible(
                      flex: 2,
                      child: CustomButton(
                          borderRadius: 50,
                          text: "Join Now",
                          onPressed: onJoinPressed),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
