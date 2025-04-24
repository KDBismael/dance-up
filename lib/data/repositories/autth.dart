import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signinWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserModel>> signupWithEmailAndPassword(
    String firstName,
    String lastName,
    String email,
    String password,
  );
  Future<Either<Failure, UserModel>> signinWithGoogle();
  Future<Either<Failure, UserModel>> signinWithApple();
  Future<Either<Failure, void>> signOut();
}
