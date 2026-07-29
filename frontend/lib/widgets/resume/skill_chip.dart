import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String text;
  final bool isMissing;

  const SkillChip({
    super.key,
    required this.text,
    this.isMissing = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
    isMissing ? Colors.redAccent : Colors.greenAccent;

    final IconData icon =
    isMissing ? Icons.close_rounded : Icons.check_rounded;

    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isMissing
              ? const [
            Color(0xFF8B0000),
            Color(0xFFD32F2F),
          ]
              : const [
            Color(0xFF11998E),
            Color(0xFF38EF7D),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(
              icon,
              color: Colors.white,
              size: 14,
            ),
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}