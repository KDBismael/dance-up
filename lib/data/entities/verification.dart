enum VerificationStatus {
  pending,
  approved,
  rejected;

  String description() {
    switch (this) {
      case VerificationStatus.pending:
        return "Pending";
      case VerificationStatus.approved:
        return "Approved";
      case VerificationStatus.rejected:
        return "Rejected";
      default:
        throw "Error";
    }
  }
}

class Verification {
  final String id;
  final String userId;
  final String proofUrl;
  final VerificationStatus status;

  Verification({
    required this.id,
    required this.userId,
    required this.proofUrl,
    required this.status,
  });

  Verification copyWith({
    String? id,
    String? userId,
    VerificationStatus? status,
    String? proofUrl,
  }) {
    return Verification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      proofUrl: proofUrl ?? this.proofUrl,
      status: status ?? this.status,
    );
  }
}
