import 'package:flutter/material.dart';

class CareerSimulatorScreen extends StatefulWidget {
  const CareerSimulatorScreen({super.key});

  @override
  State<CareerSimulatorScreen> createState() =>
      _CareerSimulatorScreenState();
}

class _CareerSimulatorScreenState
    extends State<CareerSimulatorScreen> {

  double readiness = 72;

  bool docker = false;
  bool internship = false;
  bool certification = false;
  bool project = false;

  void calculate() {

    double score = 72;

    if (docker) score += 5;
    if (internship) score += 8;
    if (certification) score += 4;
    if (project) score += 6;

    if (score > 100) score = 100;

    setState(() {
      readiness = score;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        title: const Text("Career Simulator"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Text(
            "What happens if you improve your profile?",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 25),

          Card(
            color: Colors.white10,
            child: CheckboxListTile(
              value: docker,
              activeColor: Colors.green,
              title: const Text(
                "Learn Docker",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "+5 Career Score",
                style: TextStyle(color: Colors.white70),
              ),
              onChanged: (v) {
                docker = v!;
                calculate();
              },
            ),
          ),

          Card(
            color: Colors.white10,
            child: CheckboxListTile(
              value: internship,
              activeColor: Colors.green,
              title: const Text(
                "Complete Internship",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "+8 Career Score",
                style: TextStyle(color: Colors.white70),
              ),
              onChanged: (v) {
                internship = v!;
                calculate();
              },
            ),
          ),

          Card(
            color: Colors.white10,
            child: CheckboxListTile(
              value: certification,
              activeColor: Colors.green,
              title: const Text(
                "Earn Certification",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "+4 Career Score",
                style: TextStyle(color: Colors.white70),
              ),
              onChanged: (v) {
                certification = v!;
                calculate();
              },
            ),
          ),

          Card(
            color: Colors.white10,
            child: CheckboxListTile(
              value: project,
              activeColor: Colors.green,
              title: const Text(
                "Build One Project",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "+6 Career Score",
                style: TextStyle(color: Colors.white70),
              ),
              onChanged: (v) {
                project = v!;
                calculate();
              },
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff2563EB),
                  Color(0xff7C3AED),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                const Text(
                  "Predicted Career Readiness",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "${readiness.toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: readiness / 100,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(20),
                ),

                const SizedBox(height: 20),

                Text(
                  readiness >= 90
                      ? "🎉 Excellent! You're almost job ready."
                      : readiness >= 80
                      ? "🚀 Great progress! Keep learning."
                      : "📚 Continue improving your skills.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}