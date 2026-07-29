import 'package:flutter/material.dart';

class HackathonFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const HackathonFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isSelected
                ? const LinearGradient(
              colors: [
                Color(0xff2563EB),
                Color(0xff3B82F6),
              ],
            )
                : LinearGradient(
              colors: [
                Colors.grey.shade900,
                Colors.grey.shade800,
              ],
            ),
            border: Border.all(
              color: isSelected
                  ? Colors.blueAccent
                  : Colors.white.withOpacity(.08),
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: Colors.blue.withOpacity(.35),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.grey.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}