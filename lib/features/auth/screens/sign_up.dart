import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isAgree = false;
  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Validation flags
  bool? isFirstNameValid;
  bool? isLastNameValid;
  bool? isEmailValid;
  bool? isPasswordValid;
  bool? isConfirmPasswordValid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomTextField(
          hintText: "enter your first name",
          prefixIcon: Icons.badge_outlined,
          controller: firstNameController,
          isValid: isFirstNameValid,
          errorText: isFirstNameValid == null || isFirstNameValid!
              ? null
              : "Enter a valid name",
          onChanged: validateFirstName,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: "enter your first name",
          prefixIcon: Icons.badge_outlined,
          controller: lastNameController,
          isValid: isLastNameValid,
          errorText: isLastNameValid == null || isLastNameValid!
              ? null
              : "Enter a valid name",
          onChanged: validateLastName,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          isValid: isEmailValid,
          errorText: isEmailValid == null || isEmailValid!
              ? null
              : "Enter a valid email",
          onChanged: validateEmail,
          controller: emailController,
          prefixIcon: Icons.email_outlined,
          hintText: "enter your email",
        ),
        const SizedBox(height: 10),
        CustomTextField(
          isValid: isPasswordValid,
          errorText: isPasswordValid == null || isPasswordValid!
              ? null
              : "Enter a strong password",
          onChanged: validatePassword,
          controller: passwordController,
          prefixIcon: Icons.key_outlined,
          hintText: "enter your password",
          obscureText: true,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          isValid: isConfirmPasswordValid,
          errorText: isConfirmPasswordValid == null || isConfirmPasswordValid!
              ? null
              : "Enter an identical password",
          onChanged: validateConfirmPassword,
          controller: confirmPasswordController,
          prefixIcon: Icons.key_outlined,
          hintText: "confirm your password",
          obscureText: true,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
                side: const BorderSide(color: AppColors.accent, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: AppColors.accent,
                focusColor: AppColors.accent,
                value: isAgree,
                onChanged: (val) {
                  setState(() {
                    isAgree = val ?? false;
                  });
                }),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                  text: TextSpan(
                text: "By signing up, you agree to our ",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.blackGray),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms of Service',
                    recognizer: TapGestureRecognizer(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Sign Up',
          onPressed: () {},
          isDisabled: !isAllFieldsValid(),
        ),
        const SizedBox(height: 30), // calculated status bar height
      ],
    );
  }

  @override
  dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isAllFieldsValid() {
    return isFirstNameValid == true &&
        isLastNameValid == true &&
        isEmailValid == true &&
        isPasswordValid == true &&
        isConfirmPasswordValid == true &&
        isAgree;
  }

  // Validation Logic
  void validateFirstName(String value) {
    setState(() {
      isFirstNameValid = value.trim().length > 2;
    });
  }

  void validateLastName(String value) {
    setState(() {
      isLastNameValid = value.trim().length > 2;
    });
  }

  void validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(value.trim());
    });
  }

  void validatePassword(String value) {
    setState(() {
      isPasswordValid = value.trim().length >= 8 && value != "password";
    });
    validateConfirmPassword(confirmPasswordController.text);
  }

  void validateConfirmPassword(String value) {
    setState(() {
      isConfirmPasswordValid = value == passwordController.text &&
          isPasswordValid != null &&
          isPasswordValid!;
    });
  }
}
