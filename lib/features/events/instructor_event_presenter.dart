import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructorEventController extends GetxController {
  final step = 1.obs;
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final addressController =
      TextEditingController(text: 'Rue 187, North America');

  final selectedPosition = 'Indoor'.obs;
  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      descController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      startDate.value != null &&
      endDate.value != null;

  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDateTimePicker(context);
    if (picked != null) startDate.value = picked;
  }

  Future<void> pickEndDate(BuildContext context) async {
    final picked = await showDateTimePicker(context);
    if (picked != null) endDate.value = picked;
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
