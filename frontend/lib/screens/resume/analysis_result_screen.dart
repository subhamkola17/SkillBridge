import 'package:flutter/material.dart';

import '../../models/resume_analysis_model.dart';
import '../../widgets/resume/ats_score_card.dart';
import '../../widgets/resume/improvement_title.dart';
import '../../widgets/resume/skill_chip.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis = ResumeAnalysis(
      atsScore: 88,
      strengths: [
        "Strong Flutter Knowledge",
        "Good Project Portfolio",
        "Problem Solving",
      ],
      skills: [
        "Flutter",
        "Firebase",
        "Dart",
        "Node.js",
      ],
      missingSkills: [
        "Docker",
        "AWS",
        "CI/CD",
      ],
      suggestions: [
        "Improve Professional Summary",
        "Add Quantified Achievements",
        "Use More ATS Keywords",
        "Add More Projects",
      ],
      learningRoadmap: [
        "Learn Docker",
        "Learn GitHub Actions",
        "Learn AWS Basics",
      ],
      jobMatches: [
        JobMatch(title: "Flutter Developer", percentage: 92),
        JobMatch(title: "Frontend Developer", percentage: 89),
        JobMatch(title: "Software Engineer", percentage: 84),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFF111827),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        title: const Text("Resume Analysis"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AtsScoreCard(score: analysis.atsScore),

            const SizedBox(height: 30),

            const Text(
              "Strengths",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...analysis.strengths.map(
                  (e) => ImprovementTile(
                title: e,
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Skills",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              children: analysis.skills
                  .map(
                    (skill) => SkillChip(text: skill),
              )
                  .toList(),
            ),

            const SizedBox(height: 30),

            const Text(
              "Missing Skills",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              children: analysis.missingSkills
                  .map(
                    (skill) => SkillChip(
                  text: skill,
                  isMissing: true,
                ),
              )
                  .toList(),
            ),

            const SizedBox(height: 30),

            const Text(
              "AI Suggestions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...analysis.suggestions.map(
                  (item) => ImprovementTile(
                title: item,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recommended Jobs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...analysis.jobMatches.map(
                  (job) => Card(
                color: const Color(0xFF1F2937),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.work_outline,
                    color: Colors.blue,
                  ),
                  title: Text(
                    job.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    "${job.percentage}%",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Learning Roadmap",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...analysis.learningRoadmap.map(
                  (item) => ImprovementTile(
                title: item,
                icon: Icons.school_outlined,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text(
                  "Download Report",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}