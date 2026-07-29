import 'package:flutter/material.dart';

import '../../models/skill_model.dart';

class SkillDetailScreen extends StatefulWidget {
  final SkillModel skill;

  const SkillDetailScreen({
    super.key,
    required this.skill,
  });

  @override
  State<SkillDetailScreen> createState() =>
      _SkillDetailScreenState();
}

class _SkillDetailScreenState
    extends State<SkillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        title: Text(widget.skill.title),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                const Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  widget.skill.description,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [

                    Chip(
                      label: Text(widget.skill.duration),
                    ),

                    const SizedBox(width: 10),

                    Chip(
                      label: Text(widget.skill.difficulty),
                    ),

                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Learning Resources",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...widget.skill.resources.map(
                (resource) => Card(
              color: Colors.white10,
              child: ListTile(
                leading: const Icon(
                  Icons.play_circle_fill,
                  color: Colors.blue,
                ),
                title: Text(
                  resource,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(55),
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              setState(() {
                widget.skill.completed = true;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Skill marked as completed 🎉",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.check_circle),
            label: Text(
              widget.skill.completed
                  ? "Completed"
                  : "Mark as Completed",
            ),
          ),
        ],
      ),
    );
  }
}