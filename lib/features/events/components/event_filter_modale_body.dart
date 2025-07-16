import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:dance_up/features/events/event_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventFIlterModalBody extends StatelessWidget {
  final EventPresenter presenter = Get.find<EventPresenter>();

  EventFIlterModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Type",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(EventType.values.length, (index) {
              return InkWell(
                onTap: () {
                  presenter.selectedEventType.value = EventType.values[index];
                },
                child: FilterButton(
                  isSelected: presenter.selectedEventType.value ==
                      EventType.values[index],
                  tag: EventType.values[index].description(),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            "Dance Styles",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(DanceStyle.values.length, (index) {
              return InkWell(
                onTap: () {
                  if (presenter.selectedDanceStyle
                      .contains(DanceStyle.values[index])) {
                    presenter.selectedDanceStyle
                        .remove(DanceStyle.values[index]);
                  } else {
                    presenter.selectedDanceStyle.add(DanceStyle.values[index]);
                  }
                },
                child: FilterButton(
                  isSelected: presenter.selectedDanceStyle
                      .contains(DanceStyle.values[index]),
                  tag: DanceStyle.values[index].description(),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            "Skill Level",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          CustomDropdown(
            hintText: "skill level",
            dropdownItems:
                DanceLevel.values.map((e) => e.description()).toList(),
            selectedValue: presenter.selectedDanceLevel[0].description(),
            onChanged: (p0) {
              presenter.selectedDanceLevel.value = DanceLevel.values
                  .where((e) => e.description() == p0)
                  .toList();
            },
          ),
          const SizedBox(height: 24),
          Text(
            "Price",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(Price.values.length, (index) {
              return InkWell(
                onTap: () {
                  if (presenter.selectedPrice.contains(Price.values[index])) {
                    presenter.selectedPrice.remove(Price.values[index]);
                  } else {
                    presenter.selectedPrice.add(Price.values[index]);
                  }
                },
                child: FilterButton(
                  isSelected:
                      presenter.selectedPrice.contains(Price.values[index]),
                  tag: Price.values[index].description(),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            "Position",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(DancePosition.values.length, (index) {
              return InkWell(
                onTap: () {
                  if (presenter.selectedDancePosition
                      .contains(DancePosition.values[index])) {
                    presenter.selectedDancePosition
                        .remove(DancePosition.values[index]);
                  } else {
                    presenter.selectedDancePosition
                        .add(DancePosition.values[index]);
                  }
                },
                child: FilterButton(
                  isSelected: presenter.selectedDancePosition
                      .contains(DancePosition.values[index]),
                  tag: DancePosition.values[index].description(),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          CustomButton(text: "Apply filter", onPressed: () {})
        ],
      );
    });
  }
}
