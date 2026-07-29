class DashboardStats {
  final int totalUsers;
  final int totalJobs;
  final int totalCourses;
  final int totalInternships;
  final int totalHackathons;
  final int totalMentors;
  final int pendingMentors;

  const DashboardStats({
    required this.totalUsers,
    required this.totalJobs,
    required this.totalCourses,
    required this.totalInternships,
    required this.totalHackathons,
    required this.totalMentors,
    required this.pendingMentors,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalUsers: json["totalUsers"] ?? 0,
      totalJobs: json["totalJobs"] ?? 0,
      totalCourses: json["totalCourses"] ?? 0,
      totalInternships: json["totalInternships"] ?? 0,
      totalHackathons: json["totalHackathons"] ?? 0,
      totalMentors: json["totalMentors"] ?? 0,
      pendingMentors: json["pendingMentors"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalUsers": totalUsers,
      "totalJobs": totalJobs,
      "totalCourses": totalCourses,
      "totalInternships": totalInternships,
      "totalHackathons": totalHackathons,
      "totalMentors": totalMentors,
      "pendingMentors": pendingMentors,
    };
  }

  DashboardStats copyWith({
    int? totalUsers,
    int? totalJobs,
    int? totalCourses,
    int? totalInternships,
    int? totalHackathons,
    int? totalMentors,
    int? pendingMentors,
  }) {
    return DashboardStats(
      totalUsers: totalUsers ?? this.totalUsers,
      totalJobs: totalJobs ?? this.totalJobs,
      totalCourses: totalCourses ?? this.totalCourses,
      totalInternships: totalInternships ?? this.totalInternships,
      totalHackathons: totalHackathons ?? this.totalHackathons,
      totalMentors: totalMentors ?? this.totalMentors,
      pendingMentors: pendingMentors ?? this.pendingMentors,
    );
  }
}