import 'dart:io';

import 'package:dance_up/data/repositories/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

class FirebaseStorageService implements StorageService {
  FirebaseStorageService(this._storage);
  final FirebaseStorage _storage;

  @override
  Future<String> uploadFile({
    required File file,
    String? folder,
    Map<String, dynamic>? options,
  }) async {
    final ref =
        _storage.ref(folder != null ? '$folder/${file.path}' : file.path);
    final meta = SettableMetadata(
      contentType: options?['contentType'] ??
          lookupMimeType(file.path) ??
          'application/octet-stream',
    );
    final task = ref.putFile(file, meta);

    task.snapshotEvents.listen((s) {
      if (options?['onProgress'] != null && s.totalBytes > 0) {
        options!['onProgress'](s.bytesTransferred / s.totalBytes);
      }
    });

    await task.whenComplete(() {});
    return await ref.getDownloadURL();
  }

  @override
  Future<void> delete({required String path}) async {
    await _storage.ref(path).delete();
  }
}
