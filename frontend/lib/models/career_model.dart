class CareerModel {
  final String id;
  final String title;
  final String icon;
  final String companies;
  final String salary;
  final int demand;
  final int aiMatch;
  final String duration;
  final String description;
  final List<String> skills;

  const CareerModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.companies,
    required this.salary,
    required this.demand,
    required this.aiMatch,
    required this.duration,
    required this.description,
    required this.skills,
  });
}

const List<CareerModel> careers = [

  CareerModel(
    id: "software_engineer",
    title: "Software Engineer",
    icon: "💻",
    companies: "Google • Microsoft • Amazon",
    salary: "₹18–45 LPA",
    demand: 98,
    aiMatch: 94,
    duration: "6 Months",
    description:
    "Build scalable applications, backend systems and enterprise software.",
    skills: [
      "DSA",
      "Flutter",
      "Git",
      "SQL",
      "System Design",
    ],
  ),

  CareerModel(
    id: "ai_engineer",
    title: "AI Engineer",
    icon: "🤖",
    companies: "OpenAI • NVIDIA • Google",
    salary: "₹25–60 LPA",
    demand: 99,
    aiMatch: 92,
    duration: "8 Months",
    description:
    "Design intelligent systems using AI, ML and Generative AI.",
    skills: [
      "Python",
      "Machine Learning",
      "Deep Learning",
      "TensorFlow",
      "LLMs",
    ],
  ),

  CareerModel(
    id: "flutter",
    title: "Flutter Developer",
    icon: "📱",
    companies: "Google • Swiggy • Dream11",
    salary: "₹10–28 LPA",
    demand: 95,
    aiMatch: 96,
    duration: "5 Months",
    description:
    "Create beautiful cross-platform mobile applications.",
    skills: [
      "Flutter",
      "Firebase",
      "REST API",
      "Git",
      "Dart",
    ],
  ),

  CareerModel(
    id: "data_science",
    title: "Data Scientist",
    icon: "📊",
    companies: "Netflix • IBM • Adobe",
    salary: "₹18–40 LPA",
    demand: 97,
    aiMatch: 89,
    duration: "7 Months",
    description:
    "Analyze data and build predictive models for business.",
    skills: [
      "Python",
      "Statistics",
      "Pandas",
      "SQL",
      "Machine Learning",
    ],
  ),

  CareerModel(
    id: "cyber",
    title: "Cyber Security",
    icon: "🛡",
    companies: "Cisco • Palo Alto • Microsoft",
    salary: "₹15–35 LPA",
    demand: 94,
    aiMatch: 85,
    duration: "7 Months",
    description:
    "Protect systems, networks and applications from cyber attacks.",
    skills: [
      "Linux",
      "Networking",
      "Ethical Hacking",
      "OWASP",
      "Security",
    ],
  ),

];