import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:dance_up/features/events/components/filter_button.dart';
import 'package:dance_up/features/events/instructor_event_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
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
                  children: ['Indoor', 'Outdoor'].map((position) {
                    final isSelected =
                        controller.selectedPosition.value == position;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedPosition.value = position;
                        },
                        child: FilterButton(
                          isSelected: isSelected,
                          tag: position,
                        ),
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 16),
            Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => Row(
                  // is start date selected if yes set that to take the value if end date selected set that to take the value (show selected date with border colors modified)
                  children: [
                    Expanded(
                        child: _buildDateTile(
                      label: controller.startDate.value == null
                          ? 'Start'
                          : formatDate(controller.startDate.value!),
                      onTap: () {},
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildDateTile(
                      label: controller.endDate.value == null
                          ? 'End'
                          : formatDate(controller.endDate.value!),
                      onTap: () {},
                    )),
                  ],
                )),
            const SizedBox(height: 24),
            if (true)
              SizedBox(
                height: Get.height * 0.25,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    controller.endDate.value = newDate;
                  },
                  use24hFormat: false,
                ),
              ),
            const SizedBox(height: 24),
            Obx(
              () => CustomButton(
                text: controller.step.value == 3 ? "Submit" : "Next",
                borderRadius: 16,
                disabledColor: AppColors.gray,
                onPressed: controller.isFormValid
                    ? () {
                        controller.step.value = controller.step.value + 1;
                      }
                    : null,
              ),
            ),
            Obx(
              () => TextButton(
                onPressed: () => Get.back(),
                child: Text(controller.step.value == 1 ? "Cancel" : "Previous",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.blackGray)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1, IconData? prefixIcon, required BuildContext context}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: AppColors.blackGray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      ),
    );
  }

  Widget _buildDateTile({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}
