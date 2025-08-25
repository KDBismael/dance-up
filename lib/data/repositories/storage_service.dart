import 'dart:io';

abstract class StorageService {
  /// Returns a public URL
  Future<String> uploadFile({
    // required String path, // e.g. "events/cover_123.jpg"
    // required List<int> bytes,
    // String? contentType, // "image/jpeg", "video/mp4"...
    // void Function(double progress)? onProgress, // 0..1
    required File file,
    String? folder,
    Map<String, dynamic>? options,
  });

  Future<void> delete({required String path});
}
