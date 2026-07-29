import 'package:flutter/material.dart';

import '../../widgets/career/progress_ring.dart';

class ProgressDashboardScreen extends StatelessWidget {
  const ProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        elevation: 0,
        title: const Text("Career Dashboard"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          const SizedBox(height: 10),

          const Center(
            child: ProgressRing(
              progress: .72,
              title: "Career Readiness",
              subtitle: "Excellent",
            ),
          ),

          const SizedBox(height: 35),

          Row(
            children: [

              Expanded(
                child: _statCard(
                  Icons.local_fire_department,
                  "14",
                  "Day Streak",
                  Colors.orange,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: _statCard(
                  Icons.stars,
                  "1250",
                  "XP Points",
                  Colors.amber,
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              Expanded(
                child: _statCard(
                  Icons.task_alt,
                  "18",
                  "Completed",
                  Colors.green,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: _statCard(
                  Icons.flag,
                  "7",
                  "Remaining",
                  Colors.redAccent,
                ),
              ),

            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "🤖 AI Coach",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "You're doing great! Finish SQL this week and solve 20 DSA questions. This can improve your Career Readiness from 72% to 78%.",
              style: TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Achievements",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [

              _badge("🏅", "Starter"),

              _badge("🔥", "7 Day Streak"),

              _badge("💻", "First Project"),

              _badge("🚀", "Half Roadmap"),

            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget _statCard(
      IconData icon,
      String value,
      String title,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          Icon(icon, color: color, size: 32),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _badge(
      String emoji,
      String title,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "$emoji  $title",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}