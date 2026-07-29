import 'package:flutter/material.dart';

class AIInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const AIInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            // Attachment Button
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.attach_file_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(width: 10),

            // Message Box
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                cursorColor: Colors.blue,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Ask anything about your career...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color(0xFF2563EB),
                      width: 2,
                    ),
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),

            const SizedBox(width: 10),

            // Send Button
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF2563EB),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
                onPressed: onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}