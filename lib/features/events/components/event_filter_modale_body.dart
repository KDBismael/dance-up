import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:dance_up/features/events/screens/events.dart';
import 'package:flutter/material.dart';

class EventFIlterModalBody extends StatelessWidget {
  const EventFIlterModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              child: FilterButton(
                isSelected: false,
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
              onTap: () {},
              child: FilterButton(
                isSelected: false,
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
          dropdownItems: const ['starter', 'pro'],
          onChanged: (p0) {},
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
              onTap: () {},
              child: FilterButton(
                isSelected: false,
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
          children: List.generate(Position.values.length, (index) {
            return InkWell(
              onTap: () {},
              child: FilterButton(
                isSelected: false,
                tag: Position.values[index].description(),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        CustomButton(text: "Apply filter", onPressed: () {})
      ],
    );
  }
}
