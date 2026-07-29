import 'package:flutter/material.dart';

import '../../models/career_model.dart';

class CareerCard extends StatelessWidget {
  final CareerModel career;
  final bool isSelected;
  final VoidCallback onTap;

  const CareerCard({
    super.key,
    required this.career,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: isSelected
                ? const [
              Color(0xFF2563EB),
              Color(0xFF1D4ED8),
            ]
                : const [
              Color(0xFF151B2E),
              Color(0xFF1E293B),
            ],
          ),
          border: Border.all(
            color: isSelected
                ? Colors.lightBlueAccent
                : Colors.white12,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(.35),
                blurRadius: 18,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
              children: [

                Text(
                  career.icon,
                  style: const TextStyle(fontSize: 36),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        career.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        career.companies,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 30,
                  ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              career.description,
              style: TextStyle(
                color: Colors.grey.shade300,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: career.skills
                  .map(
                    (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
                  .toList(),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    Icons.currency_rupee,
                    "Salary",
                    career.salary,
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    Icons.schedule,
                    "Roadmap",
                    career.duration,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Expanded(
                  child: _progressCard(
                    "AI Match",
                    career.aiMatch,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _progressCard(
                    "Demand",
                    career.demand,
                    Colors.orange,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.white70,
          size: 18,
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),

              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _progressCard(
      String title,
      int value,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.white12,
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(20),
          ),

          const SizedBox(height: 8),

          Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}