import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dance_up/app.dart';
import 'package:dance_up/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://251924482233796:ErYqkgrxNn_ZwixiPxbCPbjBqwI@do1e8ziil');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  cloudinary.config.urlConfig.secure = true;
  runApp(
    const DanceApp(),
  );
}
