import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
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
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
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
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
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
    );
  }
}
