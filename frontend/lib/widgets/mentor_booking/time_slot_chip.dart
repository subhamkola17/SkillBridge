import 'package:flutter/material.dart';

class TimeSlotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
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
                : Colors.white.withOpacity(0.08),
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(.35),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              color: isSelected ? Colors.white : Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade300,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}