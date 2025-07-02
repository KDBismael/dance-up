import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:flutter/material.dart';

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
