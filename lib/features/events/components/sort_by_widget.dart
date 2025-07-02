import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
