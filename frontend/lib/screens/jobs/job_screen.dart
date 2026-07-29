import 'package:flutter/material.dart';

import '../../models/job_model.dart';
import '../../services/job_service.dart';
import '../../widgets/jobs/job_card.dart';
import '../../widgets/jobs/job_filter_chip.dart';
import '../../widgets/jobs/job_search_bar.dart';
import 'job_details_screen.dart';
import 'package:dio/dio.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
final TextEditingController _searchController =
TextEditingController();

final JobService _jobService = JobService();

final List<String> filters = [
"All",
"Software",
"Flutter",
"Backend",
"AI/ML",
"Remote",
"Full Time",
"Fresher",
];

String selectedFilter = "All";

List<Job> jobs = [];

bool isLoading = true;

@override
void initState() {
super.initState();
loadJobs();
}

Future<void> loadJobs() async {
setState(() {
isLoading = true;
});

try {
final data = await _jobService.getJobs();

setState(() {
jobs = data;
isLoading = false;
});
} catch (e) {
  setState(() {
    isLoading = false;
  });

  if (!mounted) return;

  String message = "Something went wrong";

  if (e is DioException) {
    message = e.response?.data["message"] ?? message;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
title: const Text(
"Jobs",
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
centerTitle: true,
),

body: Column(
children: [
JobSearchBar(
controller: _searchController,
onChanged: (value) {
setState(() {});
},
),

SizedBox(
height: 52,
child: ListView.builder(
scrollDirection: Axis.horizontal,
padding: const EdgeInsets.symmetric(
horizontal: 16,
),
itemCount: filters.length,
itemBuilder: (context, index) {
return JobFilterChip(
label: filters[index],
isSelected:
selectedFilter == filters[index],
onTap: () {
setState(() {
selectedFilter =
filters[index];
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
child:
CircularProgressIndicator(),
)
: RefreshIndicator(
onRefresh: loadJobs,
  child: ListView.builder(
    physics:
    const AlwaysScrollableScrollPhysics(),
    itemCount: jobs.length,
    itemBuilder: (context, index) {
      final job = jobs[index];

      if (_searchController
          .text.isNotEmpty &&
          !job.title
              .toLowerCase()
              .contains(
            _searchController.text
                .toLowerCase(),
          ) &&
          !job.company
              .toLowerCase()
              .contains(
            _searchController.text
                .toLowerCase(),
          )) {
        return const SizedBox.shrink();
      }

      if (selectedFilter != "All") {
        final skillMatch =
        job.skills.any(
              (skill) => skill
              .toLowerCase()
              .contains(
            selectedFilter
                .toLowerCase(),
          ),
        );

        final remoteMatch =
            selectedFilter ==
                "Remote" &&
                job.isRemote;

        final fullTimeMatch =
            selectedFilter ==
                "Full Time" &&
                job.jobType ==
                    "Full Time";

        final fresherMatch =
            selectedFilter ==
                "Fresher" &&
                job.experience
                    .contains("0");

        if (!skillMatch &&
            !remoteMatch &&
            !fullTimeMatch &&
            !fresherMatch) {
          return const SizedBox
              .shrink();
        }
      }

      return JobCard(
        job: job,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  JobDetailsScreen(
                    job: job,
                  ),
            ),
          );
        },
        onApply: () async {
          try {
            final success =
            await _jobService
                .applyJob(
              job.id,
            );

            if (!mounted) return;

            if (success) {
              ScaffoldMessenger.of(
                  context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    "Applied successfully for ${job.title}",
                  ),
                  behavior:
                  SnackBarBehavior
                      .floating,
                ),
              );
            }
          } catch (e) {
            if (!mounted) return;

            String message = "Something went wrong";

            if (e is DioException) {
              if (e.response?.statusCode == 409) {
                message = "You have already applied for this job";
              } else {
                message = e.response?.data["message"] ?? message;
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
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