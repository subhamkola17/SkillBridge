import 'package:flutter/material.dart';

class NotesBox extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;

  const NotesBox({
    super.key,
    required this.controller,
    this.maxLength = 250,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151B2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.20),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Row(
                children: [

                  Icon(
                    Icons.edit_note_rounded,
                    color: Color(0xFF4FC3F7),
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Notes for Mentor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              TextField(
                controller: controller,
                maxLength: maxLength,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText:
                  "Describe what you'd like to discuss during the session...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(.05),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF4FC3F7),
                    ),
                  ),
                  counterText: "",
                ),
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${value.text.length}/$maxLength",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}