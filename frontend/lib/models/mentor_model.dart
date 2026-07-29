class Mentor {
  final String id;
  final String name;
  final String designation;
  final String company;
  final String expertise;
  final String experience;
  final String rating;
  final String sessions;
  final String image;
  final String bio;
  final List<String> skills;
  final List<String> languages;
  final double fee;
  final bool isSaved;

  Mentor({
    required this.id,
    required this.name,
    required this.designation,
    required this.company,
    required this.expertise,
    required this.experience,
    required this.rating,
    required this.sessions,
    required this.image,
    required this.bio,
    required this.skills,
    required this.languages,
    required this.fee,
    this.isSaved = false,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      company: json['company'] ?? '',
      expertise: json['expertise'] ?? '',
      experience: json['experience']?.toString() ?? '',
      rating: json['rating']?.toString() ?? '',
      sessions: json['sessions']?.toString() ?? '',
      image: json['profileImage'] ?? '',
      bio: json['bio'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      fee: (json['fee'] ?? 0).toDouble(),
      isSaved: json['isSaved'] ?? false,
    );
  }
}