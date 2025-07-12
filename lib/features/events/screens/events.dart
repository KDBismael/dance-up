import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/events/components/event_card.dart';
import 'package:dance_up/features/events/components/event_filter_modale_body.dart';
import 'package:dance_up/features/events/components/filter_chips.dart';
import 'package:dance_up/features/events/components/rounded_button_icon.dart';
import 'package:dance_up/features/events/components/sort_by_widget.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EventSortBy {
  recent,
  old,
  attended,
  popular;

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
      padding: const EdgeInsets.symmetric(horizontal: 19),
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
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: EventCard(
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
                    ),
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

        RoundedIconButton(
            icon: Icons.tune, // or Icons.filter_list
            onTap: () {
              showCustomModalBottomSheet(
                context: context,
                child: EventFIlterModalBody(),
              );
            }),

        const SizedBox(width: 8),

        // 📍 Location Button
        RoundedIconButton(
          icon: Icons.location_pin,
          onTap: () {},
        ),
      ],
    );
  }
}
