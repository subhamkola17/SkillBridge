import 'package:flutter/material.dart';

import '../../models/hackathon_model.dart';
import '../../widgets/hackathons/hackathon_card.dart';
import '../../widgets/hackathons/hackathon_filter_chip.dart';
import '../../widgets/hackathons/hackathon_search_bar.dart';
import 'hackathon_details_screen.dart';
import '../../services/hackathon_service.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
final TextEditingController _searchController =
TextEditingController();

String selectedFilter = "All";

final List<String> filters = [
"All",
"Online",
"Offline",
"AI",
"Flutter",
"Web",
"Open",
];

List<Hackathon> hackathons = [];

bool isLoading = true;

final HackathonService _hackathonService =
HackathonService();

@override
void initState() {
  super.initState();
  loadHackathons();
}

Future<void> loadHackathons() async {
  try {
    final data = await _hackathonService.getHackathons();

    setState(() {
      hackathons = data;
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
  final filteredHackathons = hackathons.where((hackathon) {
    final matchesSearch = hackathon.title
        .toLowerCase()
        .contains(_searchController.text.toLowerCase()) ||
        hackathon.organizer
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());

    final matchesFilter = selectedFilter == "All" ||
        hackathon.mode == selectedFilter ||
        hackathon.technologies.contains(selectedFilter);

    return matchesSearch && matchesFilter;
  }).toList();

  return Scaffold(
    backgroundColor: const Color(0xFF0F172A),
    appBar: AppBar(
      title: const Text("Hackathons"),
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
    ),
    body: Column(
      children: [
        HackathonSearchBar(
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
              return HackathonFilterChip(
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
              await loadHackathons();
            },
            child: ListView.builder(
              itemCount: filteredHackathons.length,
              itemBuilder: (context, index) {
                final hackathon =
                filteredHackathons[index];

                return HackathonCard(
                  hackathon: hackathon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            HackathonDetailsScreen(
                              hackathon: hackathon,
                            ),
                      ),
                    );
                  },
                  onRegister: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          "Registered for ${hackathon.title}",
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