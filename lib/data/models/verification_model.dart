import 'package:dance_up/data/entities/verification.dart';

class VerificationModel extends Verification {
  VerificationModel({
    required super.id,
    required super.userId,
    required super.status,
    required super.proofUrl,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      status: VerificationStatus.values.firstWhere(
        (e) => e.toString() == 'VerificationStatus.${json['status']}',
        orElse: () => VerificationStatus.pending,
      ),
      proofUrl: json['proofUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString().split('.').last,
      'proofUrl': proofUrl,
    };
  }

  factory VerificationModel.fromEntity(Verification verification) {
    return VerificationModel(
      id: verification.id,
      userId: verification.userId,
      status: verification.status,
      proofUrl: verification.proofUrl,
    );
  }
}
