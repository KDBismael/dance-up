import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/repositories/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile implements ProfileRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
