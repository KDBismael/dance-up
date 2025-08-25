import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dance_up/data/datasources/cloudinary_storage_service.dart';
import 'package:dance_up/data/datasources/firebase/auth.dart';
import 'package:dance_up/data/datasources/firebase/event.dart';
import 'package:dance_up/data/datasources/firebase/profile.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dance_up/data/repositories/event.dart';
import 'package:dance_up/data/repositories/profile.dart';
import 'package:dance_up/data/repositories/storage_service.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/events/event_presenter.dart';
import 'package:dance_up/features/events/instructor_event_presenter.dart';
import 'package:dance_up/features/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => Auth(), fenix: true);
    Get.lazyPut<ProfileRepository>(() => Profile(), fenix: true);
    Get.lazyPut<EventRepository>(() => Event(), fenix: true);
    Get.lazyPut<AuthPresenter>(() => AuthPresenter(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<EventPresenter>(() => EventPresenter(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<InstructorEventController>(() => InstructorEventController(),
        fenix: true);
    Get.lazyPut<NavigationController>(() => NavigationController(),
        fenix: true);

    // Cloudinary:
    Get.lazyPut<StorageService>(
      () => CloudinaryStorageService(
        cloudinary: Cloudinary.fromStringUrl(
            'cloudinary://251924482233796:ErYqkgrxNn_ZwixiPxbCPbjBqwI@do1e8ziil'),
        // cloudName: const String.fromEnvironment('CLOUDINARY_CLOUD_NAME'),
        // uploadPreset: const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET'),
        folder: 'danceup',
      ),
    );

    // If you want Firebase instead, swap the binding:
    // Get.lazyPut<StorageService>(() => FirebaseStorageService(FirebaseStorage.instance));
  }
}
