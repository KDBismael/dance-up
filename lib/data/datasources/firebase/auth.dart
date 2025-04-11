import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/repositories/autth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Auth implements AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Auth({required this.auth, required this.firestore});

  @override
  Future<Either<Failure, UserModel>> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) return left(const ServerFailure("User ID not found"));

      // Fetch user data from Firestore
      final userDoc = await firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        return left(const ServerFailure("User not found in database"));
      }

      final userData = userDoc.data()!;
      print(userData);
      final user = UserModel.fromJson(userData);

      return right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const FirebaseAuthFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(const FirebaseAuthFailure('Incorrect password.'));
      }
      return left(const FirebaseAuthFailure('Authentication failed.'));
    } catch (e) {
      return left(FirebaseAuthFailure('Unknown error: $e'));
    }
  }

  // Sign in with Apple you need a paid membership to the Apple Developer Program. And dig deep
  @override
  Future<Either<Failure, UserModel>> signinWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return left(const ServerFailure("Apple Sign-In failed."));
      }

      final String uid = firebaseUser.uid;
      final DocumentReference userDocRef =
          firestore.collection('users').doc(uid);

      final DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        final newUser = UserModel(
          id: uid,
          firstName: appleCredential.givenName ?? '',
          lastName: appleCredential.familyName ?? '',
          email: firebaseUser.email ?? '',
        );

        await userDocRef.set(newUser.toJson());

        return right(newUser);
      }

      final existingUser =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      return right(existingUser);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure(e.message ?? "Authentication failed."));
    } catch (e) {
      return left(FirebaseAuthFailure("Unknown error: $e"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(const ServerFailure("Google Sign-In was canceled."));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return left(const ServerFailure("Google Sign-In failed."));
      }

      final String uid = firebaseUser.uid;
      final DocumentReference userDocRef =
          firestore.collection('users').doc(uid);

      final DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        final newUser = UserModel(
          id: uid,
          firstName: firebaseUser.displayName?.split(' ').first ?? '',
          lastName: firebaseUser.displayName?.split(' ').last ?? '',
          email: firebaseUser.email ?? '',
        );

        await userDocRef.set(newUser.toJson());

        return right(newUser);
      }

      final existingUser =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      return right(existingUser);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure(e.message ?? "Authentication failed."));
    } catch (e) {
      return left(FirebaseAuthFailure("Unknown error: $e"));
    }
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
        'id': userId,
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
