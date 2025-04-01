import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/repositories/autth.dart';

class Auth implements AuthRepository {
  @override
  UserModel signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  UserModel signinWithApple() {
    // TODO: implement signinWithApple
    throw UnimplementedError();
  }

  @override
  UserModel signinWithGoogle() {
    // TODO: implement signinWithGoogle
    throw UnimplementedError();
  }

  @override
  UserModel signup(
      String firstName, String lastName, String email, String password) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
