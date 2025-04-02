import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth implements AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Auth({required this.auth, required this.firestore});

  @override
  Future<Either<Failure, UserModel>> signinWithEmailAndPassword() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signinWithApple() {
    // TODO: implement signinWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signinWithGoogle() {
    // TODO: implement signinWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signupWithEmailAndPassword(
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String userId = userCredential.user!.uid;

      await firestore.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      UserModel userModel = UserModel(
        id: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
            FirebaseAuthFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(FirebaseAuthFailure('The account already exists.'));
      } else {
        return Left(FirebaseAuthFailure('Firebase Auth Error: ${e.message}'));
      }
    } catch (e) {
      return Left(ServerFailure("Unknown Error: $e"));
    }
  }
}
