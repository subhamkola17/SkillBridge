import 'package:flutter/material.dart';

class MilestoneCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final bool unlocked;
  final int xpReward;

  const MilestoneCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.unlocked,
    required this.xpReward,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: unlocked
            ? Colors.green.withOpacity(0.12)
            : Colors.white10,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: unlocked
              ? Colors.green.withOpacity(.4)
              : Colors.white12,
        ),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: unlocked
                ? Colors.green.withOpacity(.2)
                : Colors.grey.withOpacity(.2),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),

          const SizedBox(width: 16),

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
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [

                    const Icon(
                      Icons.stars,
                      color: Colors.amber,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "+$xpReward XP",
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

          const SizedBox(width: 12),

          Icon(
            unlocked
                ? Icons.verified
                : Icons.lock_outline,
            color: unlocked
                ? Colors.green
                : Colors.grey,
            size: 28,
          ),
        ],
      ),
    );
  }
}