import 'dart:io';

import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dance_up/data/repositories/storage_service.dart';

class CloudinaryStorageService implements StorageService {
  CloudinaryStorageService({
    required this.cloudinary,
    // required this.cloudName,
    // required this.uploadPreset, // for unsigned uploads
    this.folder, // optional, e.g., "danceup"
    this.apiKey, // for signed flow (optional)
    this.signature, // pass a server-side signature (optional)
    this.timestamp,
  });

  final Cloudinary cloudinary;

  // final String cloudName;
  // final String uploadPreset;
  final String? folder;

  // Signed upload (optional)
  final String? apiKey;
  final String? signature;
  final int? timestamp;

  // @override
  // Future<String> uploadFile({
  //   required String path,
  //   required List<int> bytes,
  //   String? contentType,
  //   void Function(double progress)? onProgress,
  // }) async {
  //   // Build form
  //   final uri =
  //       Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/auto/upload');
  //   final req = http.MultipartRequest('POST', uri);

  //   // Choose unsigned or signed params
  //   if (signature != null && apiKey != null && timestamp != null) {
  //     req.fields['api_key'] = apiKey!;
  //     req.fields['timestamp'] = timestamp!.toString();
  //     req.fields['signature'] = signature!;
  //   } else {
  //     req.fields['upload_preset'] = uploadPreset;
  //   }
  //   if (folder != null) req.fields['folder'] = folder!;
  //   req.fields['public_id'] =
  //       path; // "events/cover_123" (no extension required)

  //   // Attach file
  //   req.files.add(
  //     http.MultipartFile.fromBytes(
  //       'file',
  //       bytes,
  //       filename: path.split('/').last,
  //       contentType: contentType != null ? MediaType.parse(contentType) : null,
  //     ),
  //   );

  //   // NOTE: http.MultipartRequest does not give granular progress out-of-the-box.
  //   // If you need progress, switch to `dio` and its onSendProgress callback.

  //   final streamed = await req.send();
  //   final resp = await http.Response.fromStream(streamed);
  //   if (resp.statusCode >= 200 && resp.statusCode < 300) {
  //     final json = jsonDecode(resp.body) as Map<String, dynamic>;
  //     return json['secure_url'] as String; // public URL
  //   } else {
  //     throw Exception(
  //         'Cloudinary upload failed: ${resp.statusCode} ${resp.body}');
  //   }
  // }

  @override
  Future<void> delete({required String path}) async {
    // Deleting requires a signed call with public_id and resource_type.
    // Best practice: expose a small server endpoint that accepts the public_id
    // and calls Cloudinary Admin API securely.
    throw UnimplementedError(
        'Delete should be done via a secure server endpoint.');
  }

  @override
  Future<String> uploadFile({
    required File file,
    String? folder,
    Map<String, dynamic>? options,
  }) async {
    try {
      final response = await cloudinary.uploader().upload(
            file,
            params: UploadParams(
                folder: folder ?? 'uploads',
                publicId: 'danceup/${DateTime.now().millisecondsSinceEpoch}',
                uniqueFilename: false,
                overwrite: true),
          );

      if (response?.data != null) {
        return response?.data?.secureUrl ?? '';
      } else {
        throw Exception('Upload failed: ${response?.error?.message}');
      }
    } catch (e) {
      throw Exception('Cloudinary upload error: $e');
    }
  }
}
