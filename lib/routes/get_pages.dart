import 'package:dance_up/features/profile/screens/dance_activity_info.dart';
import 'package:dance_up/features/profile/screens/edit_personal_info.dart';
import 'package:dance_up/features/profile/screens/favorite_dance_venue.dart';
import 'package:dance_up/features/profile/screens/privacy_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'routes.dart';

final getPages = [
  GetPage(
    name: Routes.screen1,
    page: () => const Placeholder(),
  ),
  GetPage(
    name: Routes.editPersonalInfo,
    page: () => EditPersonalInfo(),
  ),
  GetPage(
    name: Routes.danceActivityInfo,
    page: () => DanceActivityInfo(),
  ),
  GetPage(
    name: Routes.favoriteDanceVenue,
    page: () => const FavoriteDanceVenue(),
  ),
  GetPage(
    name: Routes.privacyControls,
    page: () => PrivacyControls(),
  ),
];
