import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/entities/verification.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/models/verification_model.dart';
import 'package:dance_up/data/repositories/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile implements ProfileRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final verificationCollection = 'InstructorVerifications';

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, UserModel>> getUserProfileById(
      String userId) async {
    try {
      final res = await firestore.collection('users').doc(userId).get();
      if (res.exists) {
        final user = UserModel.fromJson(res.data()!);
        return right(user);
      }
      return left(const ServerFailure('User not found'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserModel>> updateProfile(
      Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update(data);
      return await getUserProfileById(auth.currentUser!.uid);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, VerificationModel>> submitInstructorVerification(
      VerificationModel verification) async {
    try {
      final docRef = firestore.collection(verificationCollection).doc();
      await docRef.set(verification.toJson());
      return right(verification);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, VerificationStatus>>
      getInstructorVerificationStatus(String userId) async {
    try {
      final snapshot = await firestore
          .collection(verificationCollection)
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final verification =
            VerificationModel.fromJson(snapshot.docs.first.data());
        return right(verification.status);
      }
      return left(const ServerFailure('Verification Status not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, String?>> uploadFile(
      File file, String pathInStorage) async {
    try {
      final storageRef = storage.ref().child(pathInStorage);
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return right(downloadUrl);
    } on FirebaseException catch (e) {
      print("Error uploading file: $e");
      return left(ServerFailure(e.toString()));
    }
  }
}
