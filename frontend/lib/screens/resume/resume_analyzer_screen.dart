import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../widgets/resume/upload_resume_card.dart';
import 'analysis_result_screen.dart';

class ResumeAnalyzerScreen extends StatefulWidget {
  const ResumeAnalyzerScreen({super.key});

  @override
  State<ResumeAnalyzerScreen> createState() =>
      _ResumeAnalyzerScreenState();
}

class _ResumeAnalyzerScreenState
    extends State<ResumeAnalyzerScreen> {

  PlatformFile? selectedResume;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        title: const Text("Resume Analyzer"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              const Text(
                "Boost Your Resume",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Upload your resume and let AI analyze your ATS score, skills, strengths, and improvement areas.",
                style: TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              UploadResumeCard(
                selectedFile: selectedResume,
                onFileSelected: (file) {
                  setState(() {
                    selectedResume = file;
                  });
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: selectedResume == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const AnalysisResultScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics),
                  label: const Text(
                    "Analyze Resume",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                    Colors.grey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  "AI-powered analysis takes only a few seconds.",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}