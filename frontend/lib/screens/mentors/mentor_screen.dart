import 'package:flutter/material.dart';

import '../../models/mentor_model.dart';
import '../../widgets/mentors/mentor_card.dart';
import '../../widgets/mentors/mentor_filter_chip.dart';
import '../../widgets/mentors/mentor_search_bar.dart';
import 'mentor_details_screen.dart';
import '../mentor_booking/book_session_screen.dart';
import '../../services/mentor_service.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
final TextEditingController _searchController =
TextEditingController();

String selectedFilter = "All";

final List<String> filters = [
"All",
"AI",
"Flutter",
"Backend",
"Career",
"Web",
"Data Science",
];

List<Mentor> mentors = [];

bool isLoading = true;

final MentorService _mentorService = MentorService();

@override
void initState() {
  super.initState();
  loadMentors();
}

Future<void> loadMentors() async {
  try {
    final data = await _mentorService.getMentors();

    setState(() {
      mentors = data;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}

@override
Widget build(BuildContext context) {
  final filteredMentors = mentors.where((mentor) {
    final matchesSearch =
        mentor.name.toLowerCase().contains(
          _searchController.text.toLowerCase(),
        ) ||
            mentor.company.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            mentor.expertise.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );

    final matchesFilter = selectedFilter == "All" ||
        mentor.expertise == selectedFilter ||
        mentor.skills.contains(selectedFilter);

    return matchesSearch && matchesFilter;
  }).toList();

  return Scaffold(
    backgroundColor: const Color(0xFF0F172A),
    appBar: AppBar(
      title: const Text("Mentors"),
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
    ),
    body: Column(
      children: [
        MentorSearchBar(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
        ),

        SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
            const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filters.length,
            itemBuilder: (context, index) {
              return MentorFilterChip(
                label: filters[index],
                isSelected:
                selectedFilter == filters[index],
                onTap: () {
                  setState(() {
                    selectedFilter = filters[index];
                  });
                },
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : RefreshIndicator(
            onRefresh: () async {
              await loadMentors();
            },
            child: ListView.builder(
              itemCount: filteredMentors.length,
              itemBuilder: (context, index) {
                final mentor = filteredMentors[index];

                return MentorCard(
                  mentor: mentor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MentorDetailsScreen(
                              mentor: mentor,
                            ),
                      ),
                    );
                  },
                  onBookSession: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookSessionScreen(
                          mentor: mentor,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

@override
void dispose() {
  _searchController.dispose();
  super.dispose();
}
}