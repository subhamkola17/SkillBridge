class Internship {
  final String id;
  final String title;
  final String company;
  final String location;
  final String stipend;
  final String duration;
  final String deadline;
  final List<String> skills;
  final String logo;
  final String description;
  final bool isRemote;
  final bool isSaved;

  Internship({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.stipend,
    required this.duration,
    required this.deadline,
    required this.skills,
    required this.logo,
    required this.description,
    required this.isRemote,
    this.isSaved = false,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      stipend: json['stipend'] ?? '',
      duration: json['duration'] ?? '',
      deadline: json['deadline'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      isRemote:
      (json['type'] ?? '').toString().toLowerCase() == 'remote',
      isSaved: false,
    );
  }
}