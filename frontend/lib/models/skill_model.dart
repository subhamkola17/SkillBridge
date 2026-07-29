class SkillModel {
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final List<String> resources;
  bool completed;

  SkillModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.resources,
    this.completed = false,
  });
}