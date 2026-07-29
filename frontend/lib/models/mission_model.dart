class MissionModel {
  final String title;
  final String description;
  final int xp;
  bool completed;

  MissionModel({
    required this.title,
    required this.description,
    required this.xp,
    this.completed = false,
  });
}