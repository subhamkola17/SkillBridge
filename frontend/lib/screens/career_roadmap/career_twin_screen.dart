import 'package:flutter/material.dart';

class CareerTwinScreen extends StatelessWidget {
  const CareerTwinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        elevation: 0,
        title: const Text("AI Career Twin"),
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
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.smart_toy,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),

                    SizedBox(width: 16),

                    Expanded(
                      child: Text(
                        "Your AI Career Twin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "I'm continuously analyzing your profile and suggesting the fastest path to your dream career.",
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _insight(
            Icons.trending_up,
            Colors.green,
            "Career Readiness",
            "You are 72% ready for Software Engineer roles.",
          ),

          _insight(
            Icons.school,
            Colors.orange,
            "Next Skill",
            "Complete Docker to improve your readiness by 6%.",
          ),

          _insight(
            Icons.work,
            Colors.blue,
            "Job Matches",
            "12 jobs currently match your profile.",
          ),

          _insight(
            Icons.emoji_events,
            Colors.amber,
            "Hackathons",
            "3 AI hackathons perfectly match your skills.",
          ),

          _insight(
            Icons.description,
            Colors.purple,
            "Resume",
            "Adding one more project can improve ATS score.",
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Today's AI Challenge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Solve 5 DSA problems and complete your SQL lesson to earn 150 XP.",
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  static Widget _insight(
      IconData icon,
      Color color,
      String title,
      String message,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            backgroundColor: color.withOpacity(.2),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}