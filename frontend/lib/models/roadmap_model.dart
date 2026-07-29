import 'skill_model.dart';

class RoadmapModel {
  final String careerTitle;
  final int aiMatch;
  final int demand;
  final String duration;
  final List<SkillModel> skills;

  const RoadmapModel({
    required this.careerTitle,
    required this.aiMatch,
    required this.demand,
    required this.duration,
    required this.skills,
  });

  int get completedSkills =>
      skills.where((skill) => skill.completed).length;

  int get remainingSkills =>
      skills.length - completedSkills;

  double get progress =>
      skills.isEmpty ? 0 : completedSkills / skills.length;

  int get progressPercentage =>
      (progress * 100).toInt();
}