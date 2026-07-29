import 'package:flutter/material.dart';

import '../../widgets/career/milestone_card.dart';

class MilestoneScreen extends StatelessWidget {
  const MilestoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final milestones = [
      {
        "emoji": "🚀",
        "title": "Career Explorer",
        "description": "Create your career roadmap.",
        "xp": 100,
        "unlocked": true,
      },
      {
        "emoji": "📚",
        "title": "First Skill",
        "description": "Complete your first roadmap skill.",
        "xp": 150,
        "unlocked": true,
      },
      {
        "emoji": "🔥",
        "title": "7 Day Streak",
        "description": "Complete missions for 7 days.",
        "xp": 250,
        "unlocked": true,
      },
      {
        "emoji": "💼",
        "title": "Internship Hunter",
        "description": "Apply to 10 internships.",
        "xp": 300,
        "unlocked": false,
      },
      {
        "emoji": "🏆",
        "title": "Career Champion",
        "description": "Reach 90% career readiness.",
        "xp": 500,
        "unlocked": false,
      },
      {
        "emoji": "👑",
        "title": "SkillBridge Legend",
        "description": "Reach Level 50.",
        "xp": 1000,
        "unlocked": false,
      },
    ];

    final unlocked =
        milestones.where((e) => e["unlocked"] as bool).length;

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff0F172A),
        title: const Text("Achievements"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff2563EB),
                  Color(0xff7C3AED),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 55,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Achievement Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: unlocked / milestones.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(20),
                ),

                const SizedBox(height: 12),

                Text(
                  "$unlocked / ${milestones.length} Badges Unlocked",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            "Your Milestones",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          ...milestones.map(
                (m) => MilestoneCard(
              emoji: m["emoji"] as String,
              title: m["title"] as String,
              description: m["description"] as String,
              xpReward: m["xp"] as int,
              unlocked: m["unlocked"] as bool,
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}