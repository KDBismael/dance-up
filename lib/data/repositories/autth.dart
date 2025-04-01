import 'package:dance_up/data/models/user_model.dart';

abstract class AuthRepository {
  UserModel signin();
  UserModel signup(
    String firstName,
    String lastName,
    String email,
    String password,
  );
  UserModel signinWithGoogle();
  UserModel signinWithApple();
}
