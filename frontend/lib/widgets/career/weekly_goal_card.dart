import 'package:flutter/material.dart';

class WeeklyGoalCard extends StatelessWidget {
  final String title;
  final String description;
  final int xp;
  final bool completed;
  final ValueChanged<bool?>? onChanged;

  const WeeklyGoalCard({
    super.key,
    required this.title,
    required this.description,
    required this.xp,
    required this.completed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withOpacity(0.12)
            : Colors.white10,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: completed
              ? Colors.green.withOpacity(0.4)
              : Colors.white12,
        ),
      ),
      child: CheckboxListTile(
        value: completed,
        activeColor: Colors.green,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration:
            completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.stars,
                    color: Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "+$xp XP",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}