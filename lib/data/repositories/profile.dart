import 'dart:io';

import 'package:dance_up/core/errors/failure.dart';
import 'package:dance_up/data/entities/verification.dart';
import 'package:dance_up/data/models/user_model.dart';
import 'package:dance_up/data/models/verification_model.dart';
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
  Future<Either<ServerFailure, VerificationModel>> submitInstructorVerification(
      VerificationModel verification);
  Future<Either<ServerFailure, VerificationStatus>>
      getInstructorVerificationStatus(String userId);
  Future<Either<ServerFailure, String?>> uploadFile(
      File file, String pathInStorage);
}
