import 'package:flutter/material.dart';

import '../../models/career_model.dart';
import '../../widgets/career/career_card.dart';
import 'ai_analysis_screen.dart';

class CareerSelectionScreen extends StatefulWidget {
  const CareerSelectionScreen({super.key});

  @override
  State<CareerSelectionScreen> createState() =>
      _CareerSelectionScreenState();
}

class _CareerSelectionScreenState
    extends State<CareerSelectionScreen> {
  CareerModel? selectedCareer;

  final TextEditingController searchController =
  TextEditingController();

  String search = "";

  @override
  Widget build(BuildContext context) {
    final filtered = careers.where((career) {
      return career.title
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff0F172A),
        centerTitle: true,
        title: const Text(
          "AI Career Roadmap",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),

          child: Column(
            children: [

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's build your dream career 🚀",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose your dream career and let AI generate a personalized roadmap.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Search career...",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {

                    final career = filtered[index];

                    return CareerCard(
                      career: career,
                      isSelected:
                      selectedCareer == career,
                      onTap: () {
                        setState(() {
                          selectedCareer = career;
                        });
                      },
                    );
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xff2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: selectedCareer == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AIAnalysisScreen(
                              career: selectedCareer!,
                            ),
                      ),
                    );
                  },

                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}