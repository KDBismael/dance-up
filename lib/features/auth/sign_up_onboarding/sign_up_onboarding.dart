import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/constants/global_constant.dart';
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

  List<String> selectedDanceStyles = [];
  List<String> selectedDanceLevel = [];
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BaseWidgetWithGradient(children: [
        Obx(
          () => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 41,
                    child: Row(
                      mainAxisAlignment: OnboardingSteps.city ==
                              presenter.currentOnboardingStep.value
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        if (OnboardingSteps.city !=
                            presenter.currentOnboardingStep.value)
                          IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.white,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                presenter.onPreviousOnboardingStep();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 23,
                              )),
                        if (OnboardingSteps.city !=
                            presenter.currentOnboardingStep.value)
                          const SizedBox(width: 50),
                        Row(
                          children: [
                            Container(
                              width: 53,
                              height: 6,
                              decoration: BoxDecoration(
                                color: presenter.currentOnboardingStep.value ==
                                        OnboardingSteps.city
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
                                color: presenter.currentOnboardingStep.value ==
                                        OnboardingSteps.danceStyle
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
                                color: presenter.currentOnboardingStep.value ==
                                        OnboardingSteps.danceLevel
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
                    presenter.currentOnboardingStep.value ==
                            OnboardingSteps.city
                        ? "Select Your City"
                        : presenter.currentOnboardingStep.value ==
                                OnboardingSteps.danceStyle
                            ? "Select Your Dance Style"
                            : "Select Your Dance Level",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    presenter.currentOnboardingStep.value ==
                            OnboardingSteps.city
                        ? "Select your City to connect with local dancers. The right location helps you discover the best dance spots near you!"
                        : presenter.currentOnboardingStep.value ==
                                OnboardingSteps.danceStyle
                            ? "Choose your favorite dance style to connect with like-minded dancers and find the perfect events for you!"
                            : "From beginner to pro, pick your dance level to match with dancers at your skill level and improve together!",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  _buildStepContent(),
                  const Spacer(),
                  CustomButton(
                    text: "Submit",
                    isDisabled: isButtonDisable(),
                    isLoading: presenter.isLoading.value,
                    onPressed: () {
                      onSubmit();
                    },
                    // isDisabled: true,
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildStepContent() {
    switch (presenter.currentOnboardingStep.value) {
      case OnboardingSteps.city:
        return cityScreen(
          cityList,
          selectedValue: selectedCity,
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
        );
      case OnboardingSteps.danceStyle:
        return DanceStyle(
          list: danceStyleList,
          styleSelectedList: selectedDanceStyles,
          onChanged: setSelectedDanceStyles,
        );
      case OnboardingSteps.danceLevel:
        return DanceLevel(
          danceLevelList: danceLevelList,
          levelSelectedList: selectedDanceLevel,
          onChanged: setSelectedDanceLevel,
        );
    }
  }

  void setSelectedDanceStyles(String value) {
    if (selectedDanceStyles.contains(value)) {
      selectedDanceStyles.remove(value);
    } else {
      selectedDanceStyles.add(value);
    }
    setState(() {});
  }

  void setSelectedDanceLevel(String value) {
    if (selectedDanceLevel.contains(value)) {
      selectedDanceLevel.remove(value);
    } else if (selectedDanceLevel.isNotEmpty) {
      selectedDanceLevel[0] = value;
    } else {
      selectedDanceLevel.add(value);
    }
    setState(() {});
  }

  bool isButtonDisable() {
    if (presenter.currentOnboardingStep.value == OnboardingSteps.city) {
      return selectedCity == null;
    } else if (presenter.currentOnboardingStep.value ==
        OnboardingSteps.danceStyle) {
      return selectedDanceStyles.isEmpty;
    } else if (presenter.currentOnboardingStep.value ==
        OnboardingSteps.danceLevel) {
      return selectedDanceLevel.isEmpty;
    }
    return true;
  }

  Future<void> onSubmit() async {
    Map<String, dynamic> data = {};
    if (presenter.currentOnboardingStep.value == OnboardingSteps.city) {
      data["city"] = selectedCity;
    } else if (presenter.currentOnboardingStep.value ==
        OnboardingSteps.danceStyle) {
      data["danceStyle"] = selectedDanceStyles;
    } else if (presenter.currentOnboardingStep.value ==
        OnboardingSteps.danceLevel) {
      data["danceLevel"] = selectedDanceLevel[0];
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
    mainAxisAlignment: MainAxisAlignment.start,
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
    required this.list,
    this.onChanged,
    this.styleSelectedList = const [],
  });

  final List<String> list;
  final void Function(String)? onChanged;
  final List<String> styleSelectedList;
  @override
  Widget build(BuildContext context) {
    final listLength = (list.length / 2).ceil();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listLength,
          itemBuilder: (context, index) {
            final text1 = list[index * 2];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableContainer(
                        isSelected: styleSelectedList.contains(text1),
                        onSelect: onChanged,
                        text: text1),
                  ),
                  const SizedBox(width: 8),
                  if (index * 2 + 1 < list.length)
                    Expanded(
                      child: SelectableContainer(
                        isSelected:
                            styleSelectedList.contains(list[(index * 2) + 1]),
                        onSelect: onChanged,
                        text: list[(index * 2) + 1],
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class DanceLevel extends StatelessWidget {
  const DanceLevel({
    super.key,
    required this.danceLevelList,
    this.levelSelectedList = const [],
    this.onChanged,
  });
  final Function(String)? onChanged;
  final List<String> danceLevelList;
  final List<String> levelSelectedList;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: danceLevelList.length,
          itemBuilder: (context, index) {
            final text = danceLevelList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SelectableContainer(
                isSelected: levelSelectedList.contains(text),
                onSelect: onChanged,
                text: text,
              ),
            );
          },
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 13),
        //   decoration: BoxDecoration(
        //     color: AppColors.white,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(
        //       color: AppColors.gray,
        //       width: 1,
        //     ),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         "style 1",
        //         style: Theme.of(context).textTheme.bodyMedium,
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 8),
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 13),
        //   decoration: BoxDecoration(
        //     color: AppColors.white,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(
        //       color: AppColors.gray,
        //       width: 1,
        //     ),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         "style 1",
        //         style: Theme.of(context).textTheme.bodyMedium,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
