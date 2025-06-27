import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/components/overlapping_avatar.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EventSortBy {
  recent,
  old,
  attended,
  popular;

  @override
  String description() {
    switch (this) {
      case EventSortBy.recent:
        return "Recent";
      case EventSortBy.old:
        return "Old";
      case EventSortBy.attended:
        return "Attended";
      case EventSortBy.popular:
        return "Populare";
      default:
        throw "Error";
    }
  }
}

class Events extends StatelessWidget {
  var selectedSortBy = EventSortBy.recent.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Obx(() {
        return Column(
          children: [
            EventSearchBar(),
            const SizedBox(height: 12),
            FilterChips(),
            const SizedBox(height: 23),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedSortBy.value.description()} Events",
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
                    showCustomModalBottomSheet(
                        context: context,
                        child: SortByWidget<EventSortBy>(
                          sorby: EventSortBy.values,
                          selectedItem: selectedSortBy.value,
                          onTap: (p0) {
                            selectedSortBy.value = p0;
                          },
                          labelBuilder: (p) {
                            return p.description();
                          },
                        ));
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
        );
      }),
    ));
  }
}

class SortByWidget<T extends Enum> extends StatelessWidget {
  const SortByWidget({
    super.key,
    required this.sorby,
    required this.selectedItem,
    this.onTap,
    required this.labelBuilder,
  });

  final List<T> sorby;
  final T selectedItem;
  final String Function(T) labelBuilder;
  final void Function(T)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sort by", style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 20),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: sorby.length,
            separatorBuilder: (_, __) => const SizedBox(height: 13),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (onTap != null) onTap!(sorby[index]);
                  Get.back();
                },
                child: Row(
                  children: [
                    if (selectedItem == sorby[index])
                      const Icon(Icons.check, color: AppColors.accent),
                    if (selectedItem != sorby[index]) const SizedBox(width: 22),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        labelBuilder(sorby[index]),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.black),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventSearchBar extends StatelessWidget {
  const EventSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              showCustomModalBottomSheet(
                  context: context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Type",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(3, (index) {
                          return InkWell(
                            onTap: () {},
                            child: const FilterButton(
                              isSelected: false,
                              tag: 'All',
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Dance Styles",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(6, (index) {
                          return InkWell(
                            onTap: () {},
                            child: const FilterButton(
                              isSelected: false,
                              tag: 'Salsa',
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Skill Level",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      CustomDropdown(
                        hintText: "skill level",
                        dropdownItems: const ['starter', 'pro'],
                        onChanged: (p0) {},
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Price",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(2, (index) {
                          return InkWell(
                            onTap: () {},
                            child: const FilterButton(
                              isSelected: false,
                              tag: 'Free',
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Position",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(2, (index) {
                          return InkWell(
                            onTap: () {},
                            child: const FilterButton(
                              isSelected: false,
                              tag: 'Indoor',
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(text: "Apply filter", onPressed: () {})
                    ],
                  ));
            }),

        const SizedBox(width: 8),

        // 📍 Location Button
        _RoundedIconButton(
          icon: Icons.location_pin,
          onTap: () {},
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
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = tag == selected;

          return GestureDetector(
            onTap: () {
              setState(() {
                selected = tag;
              });
            },
            child: FilterButton(isSelected: isSelected, tag: tag),
          );
        },
      ),
    );
  }
}

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
