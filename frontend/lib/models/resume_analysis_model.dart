class ResumeAnalysis {
  final int atsScore;
  final List<String> strengths;
  final List<String> skills;
  final List<String> missingSkills;
  final List<String> suggestions;
  final List<JobMatch> jobMatches;
  final List<String> learningRoadmap;

  ResumeAnalysis({
    required this.atsScore,
    required this.strengths,
    required this.skills,
    required this.missingSkills,
    required this.suggestions,
    required this.jobMatches,
    required this.learningRoadmap,
  });

  factory ResumeAnalysis.fromJson(Map<String, dynamic> json) {
    return ResumeAnalysis(
      atsScore: json['atsScore'] ?? 0,
      strengths: List<String>.from(json['strengths'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      missingSkills: List<String>.from(json['missingSkills'] ?? []),
      suggestions: List<String>.from(json['suggestions'] ?? []),
      learningRoadmap:
      List<String>.from(json['learningRoadmap'] ?? []),
      jobMatches: (json['jobMatches'] as List<dynamic>? ?? [])
          .map((e) => JobMatch.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'atsScore': atsScore,
      'strengths': strengths,
      'skills': skills,
      'missingSkills': missingSkills,
      'suggestions': suggestions,
      'learningRoadmap': learningRoadmap,
      'jobMatches':
      jobMatches.map((e) => e.toJson()).toList(),
    };
  }
}

class JobMatch {
  final String title;
  final int percentage;

  JobMatch({
    required this.title,
    required this.percentage,
  });

  factory JobMatch.fromJson(Map<String, dynamic> json) {
    return JobMatch(
      title: json['title'] ?? '',
      percentage: json['percentage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'percentage': percentage,
    };
  }
}