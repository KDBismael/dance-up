import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/components/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AuthScreenState {
  login,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthScreenState _currentState = AuthScreenState.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.82],
                    colors: [Color(0xFF673AB7), Colors.white]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 79), // calculated status bar height
                  SvgPicture.asset(
                    "res/svg/Stars.svg",
                  ),
                  const SizedBox(height: 4),
                  SvgPicture.asset(
                    "res/svg/DanceSvg.svg",
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome to Dance !",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign up or login below to connect with dancers, and hit the dance floor!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentState = AuthScreenState.login;
                      });
                    },
                    child: _tab(
                      state: _currentState == AuthScreenState.login,
                      title: "Login",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentState = AuthScreenState.signUp;
                      });
                    },
                    child: _tab(
                      state: _currentState == AuthScreenState.signUp,
                      title: "Sign Up",
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _currentState == AuthScreenState.login
                  ? const LoginScreen()
                  : const SignUpScreen(),
            )
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CustomTextField(
          prefixIcon: Icons.person_outline,
          hintText: "enter your first name",
        ),
        const SizedBox(height: 10),
        const CustomTextField(
          prefixIcon: Icons.person_outline,
          hintText: "enter your last name",
        ),
        const SizedBox(height: 10),
        const CustomTextField(
          prefixIcon: Icons.email_outlined,
          hintText: "enter your email",
        ),
        const SizedBox(height: 10),
        const CustomTextField(
          prefixIcon: Icons.key_outlined,
          hintText: "enter your password",
          obscureText: true,
        ),
        const SizedBox(height: 10),
        const CustomTextField(
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
                value: true,
                onChanged: (val) {}),
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14.5)),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

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
        const CustomTextField(
          prefixIcon: Icons.email_outlined,
          hintText: "enter your email",
        ),
        const SizedBox(height: 20),
        const CustomTextField(
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14.5)),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.email_outlined,
//           size: 18,
//           color: AppColors.blackGray,
//         ),
//         hintText: "enter your email",
//         hintStyle: Theme.of(context)
//             .textTheme
//             .labelSmall
//             ?.copyWith(color: AppColors.blackGray),
//         border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             borderSide: BorderSide(color: AppColors.gray)),
//         enabledBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             borderSide: BorderSide(color: AppColors.gray)),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           borderSide: BorderSide(color: AppColors.primary),
//         ),
//       ),
//     );
//   }
// }

class _tab extends StatelessWidget {
  const _tab({
    super.key,
    required bool state,
    required String title,
  })  : _state = state,
        _title = title;
  final String _title;

  final bool _state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                _state ? Theme.of(context).colorScheme.primary : Colors.white,
            width: 2,
          ),
        ),
      ),
      child: Text(
        _title,
        style: _state
            ? Theme.of(context).textTheme.bodyMedium
            : Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.blackGray),
        textAlign: TextAlign.center,
      ),
    );
  }
}
