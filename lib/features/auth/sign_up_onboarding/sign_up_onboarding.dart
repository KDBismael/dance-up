import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/auth/components/custom_dropdown.dart';
import 'package:dance_up/features/auth/components/selectable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OnboardingSteps {
  city,
  danceStyle,
  danceLevel,
}

class SignUpOnboarding extends StatefulWidget {
  const SignUpOnboarding(
      {super.key}); // Add Animation to make transitions smoother
  // Add Animation to make transitions smoother
  // Add Animation to make transitions smoother

  @override
  State<SignUpOnboarding> createState() => _SignUpOnboardingState();
}

class _SignUpOnboardingState extends State<SignUpOnboarding> {
  final AuthPresenter presenter = Get.find<AuthPresenter>();

  OnboardingSteps currentStep = OnboardingSteps.city;
  final List<String> list = <String>[
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Philadelphia"
  ];
  List<String> danceStyles = [];
  List<String> danceLevel = [];
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BaseWidgetWithGradient(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 41,
                  child: Row(
                    mainAxisAlignment: OnboardingSteps.city == currentStep
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      if (OnboardingSteps.city != currentStep)
                        IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.white,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              _onPreviousStep();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 23,
                            )),
                      if (OnboardingSteps.city != currentStep)
                        const SizedBox(width: 50),
                      Row(
                        children: [
                          Container(
                            width: 53,
                            height: 6,
                            decoration: BoxDecoration(
                              color: currentStep == OnboardingSteps.city
                                  ? AppColors.accent
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 53,
                            height: 6,
                            decoration: BoxDecoration(
                              color: currentStep == OnboardingSteps.danceStyle
                                  ? AppColors.accent
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 53,
                            height: 6,
                            decoration: BoxDecoration(
                              color: currentStep == OnboardingSteps.danceLevel
                                  ? AppColors.accent
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  currentStep == OnboardingSteps.city
                      ? "Select Your City"
                      : currentStep == OnboardingSteps.danceStyle
                          ? "Select Your Dance Style"
                          : "Select Your Dance Level",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 14),
                Text(
                  currentStep == OnboardingSteps.city
                      ? "Select your City to connect with local dancers. The right location helps you discover the best dance spots near you!"
                      : currentStep == OnboardingSteps.danceStyle
                          ? "Choose your favorite dance style to connect with like-minded dancers and find the perfect events for you!"
                          : "From beginner to pro, pick your dance level to match with dancers at your skill level and improve together!",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                _buildStepContent(),
                const Spacer(),
                CustomButton(
                  text: "Submit",
                  onPressed: () {
                    onSubmit();
                    _onNextStep();
                  },
                  // isDisabled: true,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case OnboardingSteps.city:
        return cityScreen(
          list,
          selectedValue: selectedCity,
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
        );
      case OnboardingSteps.danceStyle:
        return const DanceStyle();
      case OnboardingSteps.danceLevel:
        return const DanceLevel();
    }
  }

  void _onNextStep() {
    setState(() {
      if (currentStep == OnboardingSteps.city) {
        currentStep = OnboardingSteps.danceStyle;
      } else if (currentStep == OnboardingSteps.danceStyle) {
        currentStep = OnboardingSteps.danceLevel;
      }
    });
  }

  void _onPreviousStep() {
    setState(() {
      if (currentStep == OnboardingSteps.danceLevel) {
        currentStep = OnboardingSteps.danceStyle;
      } else if (currentStep == OnboardingSteps.danceStyle) {
        currentStep = OnboardingSteps.city;
      }
    });
  }

  Future<void> onSubmit() async {
    Map<String, dynamic> data = {};
    if (currentStep == OnboardingSteps.city) {
      data["city"] = selectedCity;
    } else if (currentStep == OnboardingSteps.danceStyle) {
      data["danceStyle"] = danceStyles;
    } else if (currentStep == OnboardingSteps.danceLevel) {
      data["danceLevel"] = danceLevel;
    }
    await presenter.submitSignUpOnboarding(data);
  }
}

Widget cityScreen(
  List<String> list, {
  String? selectedValue,
  void Function(String?)? onChanged,
}) {
  return Column(
    children: [
      CustomDropdown(
        dropdownItems: list,
        hintText: "Select a city",
        selectedValue: selectedValue,
        onChanged: onChanged,
      ),
    ],
  );
}

class DanceStyle extends StatelessWidget {
  const DanceStyle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableContainer(text: "style 1"),
            SelectableContainer(text: "style 2"),
          ],
        ),
      ],
    );
  }
}

class DanceLevel extends StatelessWidget {
  const DanceLevel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.gray,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "style 1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.gray,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "style 1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
