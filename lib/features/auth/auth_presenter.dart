import 'package:dance_up/app.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPresenter extends GetxController {
  final AuthRepository repository;

  AuthPresenter(this.repository);

  final RxBool isLoading = false.obs;
  final RxString? errorMessage = RxString('');

  Future<void> signUp({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    final res = await repository.signupWithEmailAndPassword(
        firstName, lastName, email, password);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage?.value = failure.message;
        print(failure.message);
      },
      (user) {
        isLoading.value = false;
        errorMessage?.value = "";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(title: "Dance App")));

        // Get.offAll(() => const HomePage(title: "Dance App"));
      },
    );
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final res = await repository.signinWithEmailAndPassword(email, password);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage?.value = failure.message;
        print(failure.message);
      },
      (user) {
        isLoading.value = false;
        errorMessage?.value = "";
        Get.offAll(() => const HomePage(title: "Dance App"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(title: "Dance App")));
      },
    );
  }
}
