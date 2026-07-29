import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        itemBuilder: (context, index) {
          final date = today.add(Duration(days: index));

          final isSelected =
              date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 12),
              width: 72,
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
                      : Colors.white.withOpacity(.06),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    DateFormat('EEE').format(date).toUpperCase(),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white70
                          : Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}