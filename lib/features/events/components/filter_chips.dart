import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  const FilterChips(
      {super.key, required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;
  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  final List<String> tags =
      EventTag.values.map((e) => e.description()).toList();

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
          final isSelected = tag == widget.selected;

          return GestureDetector(
            onTap: () {
              widget.onSelected(tag);
            },
            child: FilterButton(isSelected: isSelected, tag: tag),
          );
        },
      ),
    );
  }
}
