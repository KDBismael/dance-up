import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/core/utils/helper.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/features/events/components/event_card.dart';
import 'package:dance_up/features/events/components/event_filter_modale_body.dart';
import 'package:dance_up/features/events/components/filter_chips.dart';
import 'package:dance_up/features/events/components/rounded_button_icon.dart';
import 'package:dance_up/features/events/components/sort_by_widget.dart';
import 'package:dance_up/features/events/event_presenter.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EventSortBy {
  recent,
  old,
  // attended,
  popular;

  String description() {
    switch (this) {
      case EventSortBy.recent:
        return "Recent";
      case EventSortBy.old:
        return "Old";
      // case EventSortBy.attended:
      //   return "Attended";
      case EventSortBy.popular:
        return "Populare";
      default:
        throw "Error";
    }
  }
}

class Events extends StatelessWidget {
  final EventPresenter presenter = Get.find<EventPresenter>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Obx(() {
        return Column(
          children: [
            if (true)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      "Events",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 28),
                    ),
                    Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        presenter.viewMode.value = presenter.viewMode.value ==
                                InstructorViewMode.dancer
                            ? InstructorViewMode.instructor
                            : InstructorViewMode.dancer;
                      },
                      label: Text(
                        presenter.viewMode.value.description(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: Icon(Icons.swap_horiz_outlined,
                          color: AppColors.white),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                    )
                  ],
                ),
              ),
            if (presenter.viewMode.value == InstructorViewMode.dancer)
              Expanded(child: DancerView()),
            if (presenter.viewMode.value == InstructorViewMode.instructor)
              Expanded(child: InstructorView())
          ],
        );
      }),
    ));
  }
}

class InstructorView extends StatelessWidget {
  const InstructorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 21),
      MenuCard(
        title: "Manage Events",
        subtitle: 'Create, edit, and manage your event.',
        onTap: () {
          Get.toNamed(Routes.manageEvent);
        },
      ),
      SizedBox(height: 20),
      MenuCard(
        title: "Activity Feed",
        onTap: () {
          Get.toNamed(Routes.instructorNews);
        },
      ),
      SizedBox(height: 20),
      MenuCard(
        title: "Create a New Event",
        onTap: () {
          Get.toNamed(Routes.instructorCreateEvent);
        },
      ),
    ]);
  }
}

class DancerView extends StatelessWidget {
  final EventPresenter presenter = Get.find<EventPresenter>();
  var selectedSortBy = EventSortBy.recent.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventSearchBar(),
        const SizedBox(height: 12),
        FilterChips(
            selected: presenter.selectedTag.value.description(),
            onSelected: (tag) {
              presenter.selectedTag.value =
                  EventTag.values.firstWhere((e) => e.description() == tag);
            }),
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
                        presenter.sortBy(p0);
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
              label: const Icon(Icons.sort, size: 18, color: AppColors.accent),
            )
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount:
                presenter.filteredEvents.length, // or your actual event count
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final event = presenter.filteredEvents[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.eventDetails, arguments: {'event': event});
                },
                child: EventCard(
                  imageUrl: event.imageUrl!,
                  title: event.name,
                  timeAgo: getEventDateLabel(event.startDate, event.endDate),
                  location: event.locationName,
                  isPaid: event.price.name == "paid",
                  onJoinPressed: () => print('Join $index'),
                  participantCount: event.attendeesIds!.length > 2
                      ? event.attendeesIds!.length - 2
                      : 0,
                  participantAvatars: event.attendeesIds!
                      .take(2)
                      .toList()
                      .map((a) => 'https://i.pravatar.cc/300')
                      .toList(),
                ),
                // child: EventCard(
                //   imageUrl:
                //       'https://dance-teacher.com/wp-content/uploads/2025/05/GettyImages-120022690.jpg',
                //   title: 'Dance Party III',
                //   timeAgo: '2 days ago',
                //   location: 'East Java',
                //   isPaid: true,
                //   onJoinPressed: () => print('Join $index'),
                //   participantCount: 22,
                //   participantAvatars: const [
                //     'https://i.pravatar.cc/300',
                //     'https://i.pravatar.cc/300'
                //   ],
                // ),
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
        RoundedIconButton(
            icon: Icons.tune, // or Icons.filter_list
            onTap: () {
              showCustomModalBottomSheet(
                context: context,
                child: EventFIlterModalBody(),
              );
            }),
        const SizedBox(width: 8),
        RoundedIconButton(
          icon: Icons.location_pin,
          onTap: () {},
        ),
      ],
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 0),
              blurStyle: BlurStyle.outer,
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 20),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                    ]
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
