import 'package:dance_up/app.dart';
import 'package:dance_up/core/services/get_storage.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dance_up/data/repositories/profile.dart';
import 'package:dance_up/features/auth/screens/auth.dart';
import 'package:dance_up/features/auth/sign_up_onboarding/sign_up_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPresenter extends GetxController {
  final AuthRepository repository;
  final ProfileRepository profileRepository;

  AuthPresenter(this.repository, this.profileRepository);

  RxBool isLoading = false.obs;
  Rx<OnboardingSteps> currentOnboardingStep = OnboardingSteps.city.obs;
  RxString? errorMessage = RxString('');
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = getPersistedUserData();
    ever(user, (user) => persistUserData(user?.toJson()));
  }

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
      (userData) {
        user.value = userData;
        isLoading.value = false;
        errorMessage?.value = "";
        Get.offAll(() => const SignUpOnboarding());
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
      (userData) {
        user.value = userData;
        isLoading.value = false;
        errorMessage?.value = "";
        Get.offAll(() => const HomePage(title: "Dance App"));
      },
    );
  }

  Future<void> signOut() async {
    await repository.signOut();
    user.value = null;
    Get.offAll(() => const AuthScreen());
  }

  Future<void> submitSignUpOnboarding(Map<String, dynamic> data) async {
    isLoading.value = true;
    final res = await profileRepository.updateProfile(data);
    res.fold(
      (failure) {
        isLoading.value = false;
        errorMessage?.value = failure.message;
        print(failure.message);
      },
      (user) {
        isLoading.value = false;
        onNextOnboardingStep();
      },
    );
  }

  void onNextOnboardingStep() {
    if (currentOnboardingStep.value == OnboardingSteps.city) {
      currentOnboardingStep.value = OnboardingSteps.danceStyle;
    } else if (currentOnboardingStep.value == OnboardingSteps.danceStyle) {
      currentOnboardingStep.value = OnboardingSteps.danceLevel;
    } else {
      Get.offAll(() => const HomePage(title: 'Dance Up'));
    }
  }

  void onPreviousOnboardingStep() {
    if (currentOnboardingStep.value == OnboardingSteps.danceLevel) {
      currentOnboardingStep.value = OnboardingSteps.danceStyle;
    } else if (currentOnboardingStep.value == OnboardingSteps.danceStyle) {
      currentOnboardingStep.value = OnboardingSteps.city;
    }
  }
}
