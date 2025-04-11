import 'package:dance_up/app.dart';
import 'package:dance_up/dependencies.dart';
import 'package:dance_up/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InitialBinding().dependencies();
  runApp(
    GetMaterialApp(
      initialBinding: InitialBinding(), // <- attach your bindings here
      home: const DanceApp(),
    ),
  );
}
