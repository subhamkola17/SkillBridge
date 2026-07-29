import 'package:flutter/material.dart';

class ImprovementTile extends StatelessWidget {
  final String title;
  final String? description;
  final IconData icon;
  final Color color;

  const ImprovementTile({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.lightbulb_outline_rounded,
    this.color = const Color(0xFF2563EB),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(
              icon,
              color: color,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                if (description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    description!,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      height: 1.4,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}