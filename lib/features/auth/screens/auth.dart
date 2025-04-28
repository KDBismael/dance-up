import 'package:dance_up/core/components/base_widget_with_gradient.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/auth/screens/sign_in.dart';
import 'package:dance_up/features/auth/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AuthScreenState {
  login,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthScreenState _currentState = AuthScreenState.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidgetWithGradient(
        children: [
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _currentState == AuthScreenState.login
                    ? const SignInScreen()
                    : const SignUpScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _tab extends StatelessWidget {
  const _tab({
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
