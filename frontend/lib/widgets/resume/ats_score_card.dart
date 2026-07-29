import 'package:flutter/material.dart';

class AtsScoreCard extends StatelessWidget {
  final int score;

  const AtsScoreCard({
    super.key,
    required this.score,
  });

  Color _getScoreColor() {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  String _getScoreLabel() {
    if (score >= 80) return "Excellent";
    if (score >= 60) return "Good";
    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "ATS SCORE",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 24),

          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: score / 100),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return SizedBox(
                height: 160,
                width: 160,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: value,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade800,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),

                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${(value * 100).toInt()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text(
                            "/100",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              _getScoreLabel(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Your resume is evaluated based on ATS compatibility, keyword optimization, formatting, and overall profile strength.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}