import 'package:flutter/material.dart';

import '../../models/ai_message_model.dart';

class AIChatBubble extends StatelessWidget {
  final AIMessage message;

  const AIChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF1D4ED8),
                  ],
                ),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

          if (!isUser)
            const SizedBox(width: 10),

          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF2563EB)
                        : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(
                        isUser ? 20 : 6,
                      ),
                      bottomRight: Radius.circular(
                        isUser ? 6 : 20,
                      ),
                    ),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          if (isUser)
            const SizedBox(width: 10),

          if (isUser)
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF334155),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
            ),
        ],
      ),
    );
  }
}