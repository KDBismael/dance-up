import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({
    super.key,
    required this.onFileSelected,
  });

  final Function(PlatformFile file)? onFileSelected;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  PlatformFile? selectedFile;

  Future<void> _pickFile() async {
    //setup to do
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );

    if (result != null && result.files.first.size <= 5 * 1024 * 1024) {
      setState(() {
        selectedFile = result.files.first;
      });
      widget.onFileSelected?.call(result.files.first);
    } else if (result != null) {
      Get.snackbar("Info", 'File too large (max 5MB)');
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return selectedFile == null ? _buildUploadPrompt() : _buildFilePreview();
  }

  Widget _buildUploadPrompt() {
    return GestureDetector(
      onTap: _pickFile,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        color: Colors.deepOrange,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          color: const Color(0xFFFEF9E6), // light yellow background
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.upload, size: 30, color: Colors.black),
              const SizedBox(height: 8),
              const Text(
                "Upload a file or document",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "JPEG, PNG and PDF up to 5 MB",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [6, 4],
      color: Colors.deepOrange,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(
              'res/images/discoverDanceEvents.png',
              // "assets/file_icon.png",
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedFile!.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${(selectedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: _removeFile,
            )
          ],
        ),
      ),
    );
  }
}
