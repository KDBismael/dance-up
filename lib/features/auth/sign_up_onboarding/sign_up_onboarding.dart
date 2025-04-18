import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

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
  OnboardingSteps currentStep = OnboardingSteps.city;
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  List<String> danceStyles = [];
  List<String> danceLevel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.20],
              colors: [Color(0xFF673AB7), Colors.white]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 79), // calculated status bar height
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
                  _onNextStep();
                },
                // isDisabled: true,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case OnboardingSteps.city:
        return CIty(list: list);
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

  void _onSubmit() {
    // Handle form submission
    // You can access the selected values from the dropdowns here
    // For example: selectedCity, selectedDanceStyle, selectedDanceLevel
  }
}

class CIty extends StatelessWidget {
  const CIty({
    super.key,
    required this.list,
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          isDense: true,
          isExpanded: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.gray,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.gray,
                width: 1,
              ),
            ),
          ),
          value: "One",
          icon: const Icon(Icons.arrow_downward),
          elevation: 360,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? value) {},
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.gray,
                  width: 1,
                ),
              ),
              child: Text(
                "style 1",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.gray,
                  width: 1,
                ),
              ),
              child: Text(
                "style 2",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
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
