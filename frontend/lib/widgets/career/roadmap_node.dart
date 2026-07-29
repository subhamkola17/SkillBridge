import 'package:flutter/material.dart';

class RoadmapNode extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool completed;
  final bool isLast;
  final VoidCallback? onTap;

  const RoadmapNode({
    super.key,
    required this.title,
    this.subtitle,
    required this.completed,
    required this.isLast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color nodeColor =
    completed ? Colors.green : const Color(0xff2563EB);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Timeline
          Column(
            children: [

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: nodeColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: nodeColor.withOpacity(.35),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: completed
                    ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                )
                    : const Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 8,
                ),
              ),

              if (!isLast)
                Container(
                  width: 2,
                  height: 72,
                  color: Colors.white24,
                ),
            ],
          ),

          const SizedBox(width: 18),

          /// Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white12,
                ),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (subtitle != null) ...[
                          const SizedBox(height: 6),

                          Text(
                            subtitle!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  Icon(
                    completed
                        ? Icons.check_circle
                        : Icons.arrow_forward_ios,
                    color: completed
                        ? Colors.green
                        : Colors.white54,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}