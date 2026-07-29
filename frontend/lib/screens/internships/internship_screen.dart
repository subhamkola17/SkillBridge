import 'package:flutter/material.dart';

import '../../models/internship_model.dart';
import '../../widgets/internships/internship_card.dart';
import '../../widgets/internships/internship_filter_chip.dart';
import '../../widgets/internships/internship_search_bar.dart';
import 'internship_details_screen.dart';
import '../../services/internship_service.dart';

class InternshipScreen extends StatefulWidget {
  const InternshipScreen({super.key});

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {
final TextEditingController _searchController =
TextEditingController();

final List<String> filters = [
"All",
"Software",
"Flutter",
"Web",
"AI/ML",
"Cloud",
"Remote",
"Data Science",
];

String selectedFilter = "All";

List<Internship> internships = [];
bool isLoading = true;

final InternshipService _internshipService = InternshipService();

@override
void initState() {
  super.initState();
  loadInternships();
}

Future<void> loadInternships() async {
  try {
    final data = await _internshipService.getInternships();

    setState(() {
      internships = data;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
elevation: 0,
backgroundColor: Colors.transparent,
title: const Text(
"Internships",
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
centerTitle: true,
),

body: Column(
children: [

InternshipSearchBar(
controller: _searchController,
onChanged: (value) {
setState(() {});
},
),

SizedBox(
height: 52,
child: ListView.builder(
padding: const EdgeInsets.symmetric(
horizontal: 16,
),
scrollDirection: Axis.horizontal,
itemCount: filters.length,
itemBuilder: (context, index) {
return InternshipFilterChip(
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
        await loadInternships();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: internships.length,
        itemBuilder: (context, index) {
          final internship = internships[index];

          if (_searchController.text.isNotEmpty &&
              !internship.title.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) &&
              !internship.company.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              )) {
            return const SizedBox.shrink();
          }

          if (selectedFilter != "All") {
            final match = internship.skills.any(
                  (skill) => skill.toLowerCase().contains(
                selectedFilter.toLowerCase(),
              ),
            );

            final remoteMatch =
                selectedFilter == "Remote" &&
                    internship.isRemote;

            if (!match && !remoteMatch) {
              return const SizedBox.shrink();
            }
          }

          return InternshipCard(
            internship: internship,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      InternshipDetailsScreen(
                        internship: internship,
                      ),
                ),
              );
            },
            onApply: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Applied for ${internship.title}",
                  ),
                  behavior:
                  SnackBarBehavior.floating,
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