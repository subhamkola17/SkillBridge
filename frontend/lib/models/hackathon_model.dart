class Hackathon {
  final String id;
  final String title;
  final String organizer;
  final String mode;
  final String location;
  final String prizePool;
  final String deadline;
  final String eventDate;
  final String teamSize;
  final String banner;
  final String description;
  final List<String> technologies;
  final bool isSaved;

  Hackathon({
    required this.id,
    required this.title,
    required this.organizer,
    required this.mode,
    required this.location,
    required this.prizePool,
    required this.deadline,
    required this.eventDate,
    required this.teamSize,
    required this.banner,
    required this.description,
    required this.technologies,
    this.isSaved = false,
  });

  factory Hackathon.fromJson(Map<String, dynamic> json) {
    return Hackathon(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      organizer: json['organizer'] ?? '',
      mode: json['mode'] ?? '',
      location: json['location'] ?? '',
      prizePool: json['prize'] ?? '',
      deadline: json['deadline'] ?? '',
      eventDate: json['eventDate'] ?? '',
      teamSize: json['teamSize'] ?? '',
      banner: json['banner'] ?? '',
      description: json['description'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      isSaved: json['isSaved'] ?? false,
    );
  }
}