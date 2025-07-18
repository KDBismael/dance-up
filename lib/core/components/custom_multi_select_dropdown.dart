import 'package:dance_up/core/theme/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  const CustomMultiSelectDropdown({
    super.key,
    this.selectedValue,
    required this.hintText,
    required this.dropdownItems,
    this.onChanged,
    required this.selectedItems,
  });

  final List<String> dropdownItems;
  final List<String> selectedItems;
  final String? selectedValue;
  final String hintText;
  final void Function(bool isSelected, String item)? onChanged;

  @override
  State<CustomMultiSelectDropdown> createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        value: widget.selectedItems.isEmpty ? null : widget.selectedItems.last,
        onMenuStateChange: (isOpen) {
          // setState(() {
          //   isMenuOpen = isOpen;
          // });
          print("isOpen: $isOpen");
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.gray,
              width: 2,
            ),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.gray,
          ),
          openMenuIcon: Icon(
            Icons.arrow_drop_up,
            color: AppColors.gray,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          // maxHeight: 200,
          elevation: 0,
          scrollPadding: const EdgeInsets.only(right: 2),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(8),
            thickness: WidgetStateProperty.all(2),
            thumbVisibility: WidgetStateProperty.all(false),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.gray,
              width: 2,
            ),
            color: AppColors.white,
          ),
          offset: const Offset(0, -8),
        ),
        // decoration: InputDecoration(
        //   filled: true,
        //   fillColor: AppColors.white,
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(8),
        //     borderSide: const BorderSide(
        //       color: AppColors.white,
        //       width: 1,
        //     ),
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(8),
        //     borderSide: const BorderSide(
        //       color: AppColors.gray,
        //       width: 1,
        //     ),
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(8),
        //     borderSide: const BorderSide(
        //       color: AppColors.gray,
        //       width: 1,
        //     ),
        //   ),
        // ),
        hint: Text(widget.hintText,
            style: Theme.of(context).textTheme.bodyMedium),
        // icon: const Icon(Icons.arrow_downward),
        style: const TextStyle(color: Colors.deepPurple),
        // dropdownColor: AppColors.white,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return widget.dropdownItems.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.selectedItems.join(', '),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        items:
            widget.dropdownItems.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem(
            value: item,
            enabled: false,
            child: StatefulBuilder(builder: (context, menuSetState) {
              final isSelected = widget.selectedItems.contains(item);
              return InkWell(
                onTap: () {
                  widget.onChanged?.call(isSelected, item);
                  isSelected
                      ? widget.selectedItems.remove(item)
                      : widget.selectedItems.add(item);
                  //This rebuilds the StatefulWidget to update the button's text
                  setState(() {});
                  //This rebuilds the dropdownMenu Widget to update the check mark
                  menuSetState(() {});
                },
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }),
          );
        }).toList(),
      ),
    );
  }
}
