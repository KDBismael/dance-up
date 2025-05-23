import 'package:dance_up/data/datasources/firebase/auth.dart';
import 'package:dance_up/data/datasources/firebase/profile.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dance_up/data/repositories/profile.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => Auth(), fenix: true);
    Get.lazyPut<ProfileRepository>(() => Profile(), fenix: true);
    Get.lazyPut<AuthPresenter>(() => AuthPresenter(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}
