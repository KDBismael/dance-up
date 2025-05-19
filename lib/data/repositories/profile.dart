import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<ServerFailure, UserModel>> updateProfile(
      Map<String, dynamic> data);
  // Future<void> updateProfileImage(String imagePath);
  // Future<void> updateProfileImageUrl(String imageUrl);
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> deleteAccount();
  Future<Either<ServerFailure, UserModel>> getUserProfileById(String userId);
}
