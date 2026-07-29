import 'package:flutter/material.dart';

class SessionTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const SessionTypeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isSelected
              ? const LinearGradient(
            colors: [
              Color(0xFF2563EB),
              Color(0xFF3B82F6),
            ],
          )
              : null,
          color: isSelected
              ? null
              : const Color(0xFF151B2E),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(.08),
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(.35),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withOpacity(.12),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
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

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                Icons.check,
                size: 16,
                color: Color(0xFF2563EB),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}