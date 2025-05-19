class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImageUrl;
  final String? city;
  final List<String>? danceStyle;
  final String? danceLevel;
  final String? bio;
  final String? username;
  final List<String>? spokenLanguages;
  final bool? isOnline;
  final bool? isSeekingDancePartner;

  User({
    this.profileImageUrl,
    this.city,
    this.danceStyle,
    this.danceLevel,
    this.bio,
    this.username,
    this.spokenLanguages,
    this.isOnline,
    this.isSeekingDancePartner,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profileImageUrl,
    String? city,
    List<String>? danceStyle,
    String? danceLevel,
    String? bio,
    String? username,
    List<String>? spokenLanguages,
    bool? isOnline,
    bool? isSeekingDancePartner,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      city: city ?? this.city,
      danceStyle: danceStyle ?? this.danceStyle,
      danceLevel: danceLevel ?? this.danceLevel,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      isOnline: isOnline ?? this.isOnline,
      isSeekingDancePartner:
          isSeekingDancePartner ?? this.isSeekingDancePartner,
    );
  }
}
