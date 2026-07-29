class UserModel {
  final String id;
  final String name;
  final String email;

  // User Role
  final String role;

  // Mentor Status
  final String mentorStatus;
  final bool mentorVerified;

  // Profile
  final String? profileImage;
  final String? phone;
  final String? location;
  final String? experience;
  final String? bio;

  final List<String> skills;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.mentorStatus,
    required this.mentorVerified,
    this.profileImage,
    this.phone,
    this.location,
    this.experience,
    this.bio,
    required this.skills,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',

      // Role
      role: json['role'] ?? 'Student',

      // Mentor
      mentorStatus: json['mentorStatus'] ?? '',
      mentorVerified: json['mentorVerified'] ?? false,

      // Profile
      profileImage: json['profileImage'],
      phone: json['phone'],
      location: json['location'],
      experience: json['experience'],
      bio: json['bio'],

      // Skills
      skills: json['skills'] != null
          ? List<String>.from(json['skills'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "role": role,
      "mentorStatus": mentorStatus,
      "mentorVerified": mentorVerified,
      "profileImage": profileImage,
      "phone": phone,
      "location": location,
      "experience": experience,
      "bio": bio,
      "skills": skills,
    };
  }
}