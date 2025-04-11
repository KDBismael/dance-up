import 'package:dance_up/data/datasources/firebase/auth.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => Auth());
    Get.lazyPut<AuthPresenter>(() => AuthPresenter(Get.find()));
  }
}
