import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/components/overlapping_avatar.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: [
          EventSearchBar(),
          const SizedBox(height: 12),
          FilterChips(),
          const SizedBox(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Events",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 20),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  backgroundColor: Colors.white, // light background
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Show sort options or bottom sheet
                },
                icon: const Text(
                  "Sort by",
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                label:
                    const Icon(Icons.sort, size: 18, color: AppColors.accent),
              )
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: 5, // or your actual event count
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return EventCard(
                  imageUrl:
                      'https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg',
                  title: 'Dance Party III',
                  timeAgo: '2 days ago',
                  location: 'East Java',
                  isPaid: true,
                  onJoinPressed: () => print('Join $index'),
                  participantCount: 22,
                  participantAvatars: const [
                    'https://i.pravatar.cc/300',
                    'https://i.pravatar.cc/300'
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class EventSearchBar extends StatelessWidget {
  const EventSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded(
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     height: 48,
        //     decoration: BoxDecoration(
        //       color: AppColors.liteGray,
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     alignment: Alignment.centerLeft,
        //     child: const Text(
        //       'Find Event',
        //       style: TextStyle(
        //         color: Colors.grey,
        //         fontSize: 16,
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.liteGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Find Event',
                border: InputBorder.none,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.gray),
              ),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.black),
            ),
          ),
        ),

        const SizedBox(width: 8),

        _RoundedIconButton(
          icon: Icons.tune, // or Icons.filter_list
          onTap: () {
            // Open filter modal
          },
        ),

        const SizedBox(width: 8),

        // 📍 Location Button
        _RoundedIconButton(
          icon: Icons.location_pin,
          onTap: () {
            // Show location events
          },
        ),
      ],
    );
  }
}

class _RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundedIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: AppColors.liteGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 24, color: Colors.grey[700]),
        onPressed: onTap,
        splashRadius: 24,
      ),
    );
  }
}

class FilterChips extends StatefulWidget {
  const FilterChips({super.key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  final List<String> tags = [
    "Chill",
    "Energetic",
    "Live music",
    "Touristy",
    "Cultural"
  ];
  String selected = "Chill";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = tag == selected;

          return GestureDetector(
            onTap: () {
              setState(() {
                selected = tag;
              });
            },
            child: Container(
              // height: 28,
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.5, vertical: 8),
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
            ),
          );
        },
      ),
    );
  }
}

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
