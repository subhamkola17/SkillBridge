import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/career_model.dart';
import 'roadmap_screen.dart';

class AIAnalysisScreen extends StatefulWidget {
  final CareerModel career;

  const AIAnalysisScreen({
    super.key,
    required this.career,
  });

  @override
  State<AIAnalysisScreen> createState() =>
      _AIAnalysisScreenState();
}

class _AIAnalysisScreenState
    extends State<AIAnalysisScreen> {

  int currentStep = 0;

  final List<String> steps = [
    "Analyzing your profile...",
    "Checking your skills...",
    "Reviewing internships...",
    "Reviewing hackathons...",
    "Checking resume...",
    "Finding skill gaps...",
    "Building personalized roadmap...",
    "Almost Done...",
  ];

  @override
  void initState() {
    super.initState();
    startAnalysis();
  }

  void startAnalysis() {
    Timer.periodic(const Duration(seconds: 1), (timer) {

      if (currentStep < steps.length - 1) {

        setState(() {
          currentStep++;
        });

      } else {

        timer.cancel();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RoadmapScreen(
              career: widget.career,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff0F172A),

      body: SafeArea(

        child: Center(

          child: Padding(

            padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(.15),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.blue,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "AI Career Coach",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Preparing roadmap for\n${widget.career.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 50),

                const CircularProgressIndicator(
                  strokeWidth: 6,
                ),

                const SizedBox(height: 35),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    steps[currentStep],
                    key: ValueKey(currentStep),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 25),

                LinearProgressIndicator(
                  value: (currentStep + 1) / steps.length,
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 10,
                ),

                const SizedBox(height: 15),

                Text(
                  "${(((currentStep + 1) / steps.length) * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}