import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final String title;
  final String subtitle;
  final Color color;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.title,
    required this.subtitle,
    this.color = const Color(0xff2563EB),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [

          SizedBox(
            width: 170,
            height: 170,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}