import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() =>
      _FeedbackScreenState();
}

class _FeedbackScreenState
    extends State<FeedbackScreen> {

  int rating = 5;

  final TextEditingController feedbackController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1120),
        title: const Text("Session Feedback"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Icon(
              Icons.emoji_events,
              size: 90,
              color: Colors.amber,
            ),

            const SizedBox(height: 20),

            const Text(
              "How was your mentorship session?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                  icon: Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 36,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: feedbackController,
              maxLines: 5,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Write your feedback...",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                filled: true,
                fillColor: const Color(0xFF151B2E),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF2563EB),
                ),
                onPressed: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Thank you for your feedback!",
                      ),
                    ),
                  );

                  Navigator.popUntil(
                    context,
                        (route) => route.isFirst,
                  );
                },
                child: const Text(
                  "Submit Feedback",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}