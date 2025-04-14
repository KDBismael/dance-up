import 'package:dance_up/app.dart';
import 'package:dance_up/core/theme/theme.dart';
import 'package:dance_up/dependencies.dart';
import 'package:dance_up/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InitialBinding().dependencies();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(), // <- attach your bindings here
      home: const DanceApp(),
    ),
  );
}
