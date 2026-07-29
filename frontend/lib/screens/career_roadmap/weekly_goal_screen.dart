import 'package:flutter/material.dart';

import '../../models/mission_model.dart';

class WeeklyGoalScreen extends StatefulWidget {
  const WeeklyGoalScreen({super.key});

  @override
  State<WeeklyGoalScreen> createState() =>
      _WeeklyGoalScreenState();
}

class _WeeklyGoalScreenState
    extends State<WeeklyGoalScreen> {

  final List<MissionModel> missions = [

    MissionModel(
      title: "Solve DSA Problems",
      description: "Solve 5 LeetCode questions.",
      xp: 100,
    ),

    MissionModel(
      title: "Watch SQL Lesson",
      description: "Complete one SQL tutorial.",
      xp: 80,
    ),

    MissionModel(
      title: "Update Resume",
      description: "Add your latest project.",
      xp: 50,
    ),

    MissionModel(
      title: "Apply Internship",
      description: "Apply to one internship.",
      xp: 120,
    ),

    MissionModel(
      title: "Read System Design",
      description: "Study one architecture concept.",
      xp: 90,
    ),

  ];

  @override
  Widget build(BuildContext context) {

    final completed =
        missions.where((e) => e.completed).length;

    final totalXP = missions
        .where((e) => e.completed)
        .fold(0, (a, b) => a + b.xp);

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        title: const Text("Daily AI Missions"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff2563EB),
                  Color(0xff7C3AED),
                ],
              ),
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                const Text(
                  "Today's Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                LinearProgressIndicator(
                  value: completed / missions.length,
                  minHeight: 10,
                  borderRadius:
                  BorderRadius.circular(20),
                ),

                const SizedBox(height: 12),

                Text(
                  "$completed / ${missions.length} Missions",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "$totalXP XP Earned",
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          ...missions.map(
                (mission) => Card(
              color: Colors.white10,
              child: CheckboxListTile(
                value: mission.completed,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    mission.completed = value!;
                  });
                },
                title: Text(
                  mission.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "${mission.description}\n+${mission.xp} XP",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}