import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:dance_up/features/events/screens/instructors/attendees.dart';
import 'package:dance_up/features/events/screens/instructors/create_event_screen.dart';
import 'package:dance_up/features/events/screens/instructors/event_details.dart';
import 'package:dance_up/features/events/screens/instructors/manage_event.dart';
import 'package:dance_up/features/events/screens/instructors/news.dart';
import 'package:dance_up/features/events/screens/instructors/photos.dart';
import 'package:dance_up/features/events/screens/instructors/reviews.dart';
import 'package:dance_up/features/profile/screens/dance_activity_info.dart';
import 'package:dance_up/features/profile/screens/edit_personal_info.dart';
import 'package:dance_up/features/profile/screens/favorite_dance_venue.dart';
import 'package:dance_up/features/profile/screens/followers_screen.dart';
import 'package:dance_up/features/profile/screens/following_screen.dart';
import 'package:dance_up/features/profile/screens/guest_profile.dart';
import 'package:dance_up/features/profile/screens/partners_screen.dart';
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
  GetPage(
    name: Routes.partnersScreen,
    page: () => const PartnersScreen(),
  ),
  GetPage(
    name: Routes.followingsScreen,
    page: () => const FollowingsScreen(),
  ),
  GetPage(
    name: Routes.followersScreen,
    page: () => const FollowersScreen(),
  ),
  GetPage(
    name: Routes.guestProfile,
    page: () => GuestProfile(),
  ),
  GetPage(
    name: Routes.eventDetails,
    page: () => EventDetailsScreen(),
  ),
  GetPage(
    name: Routes.manageEvent,
    page: () => ManageEventsScreen(),
  ),
  GetPage(
    name: Routes.instructorEventDetails,
    page: () => InstructorEventDetailsScreen(),
  ),
  GetPage(
    name: Routes.instructorPhotos,
    page: () => InstructorPhotosScreen(),
  ),
  GetPage(
    name: Routes.instructorAttendees,
    page: () => InstructorAttendeesScreen(),
  ),
  GetPage(
    name: Routes.instructorReviews,
    page: () => InstructorReviewsScreen(),
  ),
  GetPage(
    name: Routes.instructorNews,
    page: () => InstructorNewsScreen(),
  ),
  GetPage(
    name: Routes.instructorCreateEvent,
    page: () => CreateEventScreen(),
  ),
];
