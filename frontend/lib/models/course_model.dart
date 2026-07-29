class Course {
  final String id;
  final String title;
  final String instructor;
  final String category;
  final String duration;
  final String level;
  final String rating;
  final String students;
  final String thumbnail;
  final String description;
  final List<String> skills;
  final bool isSaved;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.duration,
    required this.level,
    required this.rating,
    required this.students,
    required this.thumbnail,
    required this.description,
    required this.skills,
    this.isSaved = false,
  });
}