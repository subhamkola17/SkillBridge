import 'package:flutter/material.dart';

import '../../models/career_model.dart';
import '../../models/skill_model.dart';
import 'skill_detail_screen.dart';
import 'weekly_goal_screen.dart';
import 'progress_dashboard_screen.dart';
import 'career_twin_screen.dart';
import 'career_simulator_screen.dart';
import 'milestone_screen.dart';

class RoadmapScreen extends StatelessWidget {
final CareerModel career;

const RoadmapScreen({
super.key,
required this.career,
});

List<SkillModel> get roadmap => [
SkillModel(
title: "Git & GitHub",
description:
"Learn version control, Git workflow and GitHub collaboration.",
duration: "1 Week",
difficulty: "Easy",
resources: [
"GitHub Crash Course",
"Git Official Documentation",
"Create Portfolio Repository",
],
),
SkillModel(
title: "Data Structures & Algorithms",
description:
"Master coding interview questions and problem-solving.",
duration: "6 Weeks",
difficulty: "Hard",
resources: [
"Striver A2Z Sheet",
"LeetCode",
"NeetCode",
],
),
SkillModel(
title: "SQL",
description:
"Learn relational databases and SQL queries.",
duration: "2 Weeks",
difficulty: "Medium",
resources: [
"SQLBolt",
"MySQL Tutorial",
"Practice SQL",
],
),
SkillModel(
title: "System Design",
description:
"Understand scalable backend architecture and design patterns.",
duration: "4 Weeks",
difficulty: "Hard",
resources: [
"System Design Primer",
"Grokking System Design",
"Design Twitter Clone",
],
),
];

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
backgroundColor: const Color(0xff0F172A),
elevation: 0,
title: const Text("AI Career Roadmap"),
),

body: ListView(
padding: const EdgeInsets.all(18),
children: [

/// Career Header
Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(22),
gradient: const LinearGradient(
colors: [
Color(0xff2563EB),
Color(0xff1D4ED8),
],
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Text(
career.icon,
style: const TextStyle(fontSize: 46),
),

const SizedBox(height: 12),

Text(
career.title,
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 28,
),
),

const SizedBox(height: 8),

Text(
career.description,
style: const TextStyle(
color: Colors.white70,
),
),

const SizedBox(height: 20),

Wrap(
spacing: 10,
runSpacing: 10,
children: [

_chip(
Icons.schedule,
career.duration,
),

_chip(
Icons.currency_rupee,
career.salary,
),

_chip(
Icons.trending_up,
"${career.demand}% Demand",
),

],
),
],
),
),

const SizedBox(height: 25),

const Text(
"Career Readiness",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

ClipRRect(
borderRadius: BorderRadius.circular(20),
child: LinearProgressIndicator(
value: career.aiMatch / 100,
minHeight: 12,
),
),

const SizedBox(height: 8),

Text(
"${career.aiMatch}% AI Match Score",
style: const TextStyle(
color: Colors.greenAccent,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 30),

const Text(
"Learning Journey",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 22,
),
),

const SizedBox(height: 18),

...roadmap.map(
(skill) => GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
SkillDetailScreen(skill: skill),
),
);
},
child: _timelineItem(
skill.title,
skill == roadmap.last,
skill.completed,
),
),
),

const SizedBox(height: 30),

Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: Colors.white10,
borderRadius: BorderRadius.circular(20),
),
child: const Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"🤖 AI Career Coach",
style: TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 12),

Text(
"Focus on completing one skill every week. Your AI Match Score will improve automatically as you finish roadmap milestones.",
style: TextStyle(
color: Colors.white70,
height: 1.4,
),
),

],
),
),

const SizedBox(height: 30),

  const Text(
    "Quick Tools",
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 16),

  Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [

      ActionChip(
        label: const Text("🎯 Weekly Goals"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const WeeklyGoalScreen(),
            ),
          );
        },
      ),

      ActionChip(
        label: const Text("📊 Progress"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProgressDashboardScreen(),
            ),
          );
        },
      ),

      ActionChip(
        label: const Text("🧠 Career Twin"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CareerTwinScreen(),
            ),
          );
        },
      ),

      ActionChip(
        label: const Text("🚀 Simulator"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CareerSimulatorScreen(),
            ),
          );
        },
      ),

      ActionChip(
        label: const Text("🏆 Achievements"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MilestoneScreen(),
            ),
          );
        },
      ),
    ],
  ),

  const SizedBox(height: 30),
],
),
);
}
Widget _chip(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _timelineItem(
    String title,
    bool isLast,
    bool completed,
    ) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: completed
                  ? Colors.green
                  : const Color(0xff2563EB),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (completed
                      ? Colors.green
                      : const Color(0xff2563EB))
                      .withOpacity(.4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: completed
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            )
                : const Icon(
              Icons.circle,
              color: Colors.white,
              size: 8,
            ),
          ),
          if (!isLast)
            Container(
              width: 2,
              height: 65,
              color: Colors.white24,
            ),
        ],
      ),

      const SizedBox(width: 18),

      Expanded(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Icon(
                completed
                    ? Icons.check_circle
                    : Icons.arrow_forward_ios,
                color: completed
                    ? Colors.green
                    : Colors.white54,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
}