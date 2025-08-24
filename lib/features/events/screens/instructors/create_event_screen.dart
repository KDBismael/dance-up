import 'dart:io';

import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/components/custom_dropdown.dart';
import 'package:dance_up/core/components/upload_files.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/data/models/event_model.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:dance_up/features/events/instructor_event_presenter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventScreen extends StatelessWidget {
  final InstructorEventController controller =
      Get.find<InstructorEventController>();

  CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Text("New Event", style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: controller.step.value == 1
              ? StepOne(
                  buttonWidgets: buttonWidgets(context),
                )
              : StepTwo(
                  buttonWidgets: buttonWidgets(context),
                ),
        ),
      ),
    );
  }

  Widget buttonWidgets(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 24),
          CustomButton(
            text: controller.step.value == 2 ? "Submit" : "Next",
            borderRadius: 16,
            disabledColor: AppColors.gray,
            onPressed: controller.isFormValid && controller.step.value == 1
                ? () {
                    controller.step.value = controller.step.value + 1;
                  }
                : controller.isValid && controller.step.value == 2
                    ? () {
                        controller.submit();
                      }
                    : null,
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(controller.step.value == 1 ? "Cancel" : "Previous",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.blackGray)),
          ),
        ],
      ),
    );
  }
}

class StepOne extends StatelessWidget {
  StepOne({super.key, required this.buttonWidgets});
  final InstructorEventController controller =
      Get.find<InstructorEventController>();

  final Widget buttonWidgets;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Event Details",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Event Name',
          prefixIcon: Icons.badge_outlined,
          controller: controller.nameController,
          isValid: true,
          errorText: null,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller.descController,
          hintText: 'Event Description...',
          maxLines: 4,
          isValid: true,
          errorText: null,
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller.addressController,
          hintText: 'Event Location...',
          prefixIcon: Icons.location_on,
          isValid: true,
          errorText: null,
        ),
        const SizedBox(height: 16),
        Text("Position",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 20)),
        const SizedBox(height: 7),
        Obx(() => Row(
              children: DancePosition.values.map((position) {
                final isSelected =
                    controller.selectedPosition.value == position.name;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedPosition.value = position.name;
                    },
                    child: FilterButton(
                      isSelected: isSelected,
                      tag: position.description(),
                    ),
                  ),
                );
              }).toList(),
            )),
        const SizedBox(height: 16),
        Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Obx(() => Row(
              children: [
                Expanded(
                    child: _buildDateTile(
                  label: controller.startDate.value == null
                      ? 'Start'
                      : formatDate(controller.startDate.value!),
                  isSelected: controller.isStartDateSelected.value,
                  isFilled: controller.startDate.value != null,
                  onTap: () {
                    controller.isStartDateSelected.value = true;
                    controller.isEndDateSelected.value = false;
                  },
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildDateTile(
                  label: controller.endDate.value == null
                      ? 'End'
                      : formatDate(controller.endDate.value!),
                  isSelected: controller.isEndDateSelected.value,
                  isFilled: controller.endDate.value != null,
                  onTap: () {
                    controller.isStartDateSelected.value = false;
                    controller.isEndDateSelected.value = true;
                  },
                )),
              ],
            )),
        const SizedBox(height: 24),
        Obx(
          () => Column(
            children: [
              if (controller.isStartDateSelected.value ||
                  controller.isEndDateSelected.value)
                SizedBox(
                  height: Get.height * 0.25,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      if (controller.isStartDateSelected.value) {
                        controller.pickStartDate(context, newDate);
                      } else {
                        controller.pickEndDate(context, newDate);
                      }
                    },
                    use24hFormat: false,
                  ),
                ),
            ],
          ),
        ),
        buttonWidgets
      ],
    );
  }

  // Widget _buildTextField(TextEditingController controller, String hint,
  //     {int maxLines = 1, IconData? prefixIcon, required BuildContext context}) {
  //   return TextField(
  //     controller: controller,
  //     maxLines: maxLines,
  //     decoration: InputDecoration(
  //       prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
  //       hintText: hint,
  //       hintStyle: Theme.of(context)
  //           .textTheme
  //           .labelSmall
  //           ?.copyWith(color: AppColors.blackGray),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: AppColors.gray),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: AppColors.gray),
  //       ),
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
  //     ),
  //   );
  // }

  Widget _buildDateTile(
      {required String label,
      required VoidCallback onTap,
      bool isSelected = false,
      bool isFilled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border:
              Border.all(color: isSelected ? AppColors.accent : AppColors.gray),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: AppColors.blackGray),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: isFilled ? Colors.black : AppColors.blackGray)),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}

class StepTwo extends StatelessWidget {
  StepTwo({super.key, required this.buttonWidgets});

  final Widget buttonWidgets;
  final InstructorEventController c = Get.find<InstructorEventController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: _FieldLabelColumn(
                label: "Price",
                child: CustomTextField(
                  prefixText: "\$ ",
                  hintText: 'price',
                  value: "0",
                  keyboardType: TextInputType.number,
                  // label: "Price",
                  controller: c.priceCtrl,
                  onChanged: (_) => c.update(),
                  isValid: true,
                  errorText: null,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _FieldLabelColumn(
                label: "Dance Style",
                child: Obx(() {
                  return CustomDropdown(
                    dropdownItems:
                        DanceStyle.values.map((e) => e.description()).toList(),
                    hintText: "Dance Style",
                    onChanged: (v) => c.selectedDanceStyle.value = v,
                    selectedValue: c.selectedDanceStyle.value,
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _FieldLabelColumn(
          label: "Dance Level",
          child: Obx(() {
            return CustomDropdown(
              hintText: "Dance Level",
              selectedValue: c.selectedDanceLevel.value,
              onChanged: (v) => c.selectedDanceLevel.value = v,
              dropdownItems: DanceLevel.values.map((e) => e.name).toList(),
            );
          }),
        ),
        const SizedBox(height: 20),
        const Text("Vibe Tags",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Obx(() {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: EventTag.values.map((t) {
              final selected = c.selectedTags.contains(t.name);
              return InkWell(
                onTap: () {
                  c.toggleTag(t.name);
                },
                child: FilterButton(
                  isSelected: selected,
                  tag: t.description(),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 24),
        const Text("Event Cover",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        UploadFile(
          // change this to select from gallery
          onFileSelected: (PlatformFile file) {
            c.coverFile.value = file as File;
          },
        ),
        buttonWidgets
      ],
    );
  }
}

class _FieldLabelColumn extends StatelessWidget {
  final String label;
  final Widget child;
  const _FieldLabelColumn({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
