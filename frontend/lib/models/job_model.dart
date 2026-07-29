class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String experience;
  final String jobType;
  final String postedDate;
  final List<String> skills;
  final String logo;
  final String description;
  final bool isRemote;
  final bool isSaved;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.experience,
    required this.jobType,
    required this.postedDate,
    required this.skills,
    required this.logo,
    required this.description,
    required this.isRemote,
    this.isSaved = false,
  });
}