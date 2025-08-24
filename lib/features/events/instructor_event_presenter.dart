import 'dart:io';

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
  final isEndDateSelected = false.obs;
  final isStartDateSelected = false.obs;
  final priceCtrl = TextEditingController(text: "0");
  final selectedTags = <String>{}.obs;
  final selectedDanceStyle = Rxn<String>();
  final selectedDanceLevel = Rxn<String>();
  final coverFile = Rxn<File>();

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      descController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      startDate.value != null &&
      endDate.value != null;

  Future<void> pickStartDate(BuildContext context, DateTime? picked) async {
    if (picked != null) startDate.value = picked;
    isStartDateSelected.value = true;
  }

  Future<void> pickEndDate(BuildContext context, DateTime? picked) async {
    if (picked != null) endDate.value = picked;
    isEndDateSelected.value = true;
  }

  bool get isValid {
    final priceOk = double.tryParse(priceCtrl.text.trim()) != null;
    return priceOk &&
        selectedDanceStyle.value != null &&
        selectedDanceLevel.value != null &&
        coverFile.value != null;
  }

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void setCover(File file, {required String name, required String sizeLabel}) {
    coverFile.value = file;
  }

  void removeCover() {
    coverFile.value = null;
  }

  void submit() {
    if (!isValid && !isFormValid) return;
    final payload = {
      'price': double.parse(priceCtrl.text.trim()),
      'danceStyle': selectedDanceStyle.value,
      'danceLevel': selectedDanceLevel.value,
      'tags': selectedTags.toList(),
      'cover': ''
      // 'cover': coverFileName.value,
    };
    print('Form submitted with payload: $payload');
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    addressController.dispose();
    priceCtrl.dispose();
    coverFile.value?.delete();
    super.onClose();
  }
}
