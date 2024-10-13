// lib/models/profile.dart

class Profile {
  final String userId;
  final String? name;
  final String? bio;
  final String? profession;
  final List<String>? interests;
  final String? profilePictureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    required this.userId,
    this.name,
    this.bio,
    this.profession,
    this.interests,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['user_id'] ?? '',
      name: json['name'],
      bio: json['bio'],
      profession: json['profession'],
      interests:
          json['interests'] != null ? List<String>.from(json['interests']) : [],
      profilePictureUrl: json['profile_picture_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'bio': bio,
      'profession': profession,
      'interests': interests,
      'profile_picture_url': profilePictureUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
