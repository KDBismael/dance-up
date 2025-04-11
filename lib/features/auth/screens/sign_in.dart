import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/auth_presenter.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthPresenter presenter = Get.find<AuthPresenter>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? isEmailValid;
  bool? isPasswordValid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "res/svg/Facebook.svg",
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Login with Apple",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "res/svg/Facebook.svg",
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Login with Google",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 1,
              color: AppColors.blackGray,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: Text(
                "or continue with email",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      backgroundColor: Colors.white,
                      color: AppColors.blackGray,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
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
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Forgot Password?",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Login',
          onPressed: () {
            if (isAllFieldsValid()) {
              presenter.signIn(
                context: context,
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
          isDisabled: !isAllFieldsValid(),
        ),
      ],
    );
  }

  bool isAllFieldsValid() {
    return isEmailValid == true && isPasswordValid == true;
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
  }
}
