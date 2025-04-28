import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find<NavigationController>();

  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
