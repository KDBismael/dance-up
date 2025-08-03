import 'package:dance_up/data/entities/user.dart';

enum InstructorViewMode {
  dancer,
  instructor;

  String description() {
    switch (this) {
      case InstructorViewMode.dancer:
        return "Dancer";
      case InstructorViewMode.instructor:
        return "Instructor";
      default:
        throw "Error";
    }
  }
}

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.profileImageUrl,
    super.city,
    super.danceStyle,
    super.danceLevel,
    super.bio,
    super.username,
    super.spokenLanguages,
    super.isOnline,
    super.isSeekingDancePartner,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      city: json['city'],
      danceStyle: List<String>.from(json['danceStyle'] ?? []),
      danceLevel: json['danceLevel'],
      bio: json['bio'],
      username: json['username'],
      spokenLanguages: List<String>.from(json['spokenLanguages'] ?? []),
      isOnline: json['isOnline'],
      isSeekingDancePartner: json['isSeekingDancePartner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'city': city,
      'danceStyle': danceStyle,
      'danceLevel': danceLevel,
      'bio': bio,
      'username': username,
      'spokenLanguages': spokenLanguages,
      'isOnline': isOnline,
      'isSeekingDancePartner': isSeekingDancePartner,
    };
  }

  // Convert Entity to Model
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      profileImageUrl: user.profileImageUrl,
      city: user.city,
      danceStyle: user.danceStyle,
      danceLevel: user.danceLevel,
      bio: user.bio,
      username: user.username,
      spokenLanguages: user.spokenLanguages,
      isOnline: user.isOnline,
      isSeekingDancePartner: user.isSeekingDancePartner,
    );
  }
}
