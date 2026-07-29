import 'package:flutter/material.dart';

import '../../models/job_model.dart';
import '../../services/job_service.dart';
import 'package:dio/dio.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailsScreen> createState() =>
      _JobDetailsScreenState();
}

class _JobDetailsScreenState
    extends State<JobDetailsScreen> {
final JobService _jobService = JobService();

bool isApplying = false;

Future<void> applyJob() async {
if (isApplying) return;

setState(() {
isApplying = true;
});

try {
final success = await _jobService.applyJob(
widget.job.id,
);

if (!mounted) return;

if (success) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
"Application submitted successfully!",
),
behavior: SnackBarBehavior.floating,
),
);
}
} catch (e) {
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
} finally {
if (mounted) {
setState(() {
isApplying = false;
});
}
}
}

@override
Widget build(BuildContext context) {
final job = widget.job;

return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
title: const Text("Job Details"),
),

body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Center(
child: Hero(
tag: job.id,
child: Container(
height: 95,
width: 95,
decoration: BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(20),
),
clipBehavior: Clip.antiAlias,
child: Image.network(
job.logo,
fit: BoxFit.cover,
),
),
),
),

const SizedBox(height: 22),

Center(
child: Text(
job.title,
textAlign: TextAlign.center,
style: const TextStyle(
color: Colors.white,
fontSize: 26,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 8),

Center(
child: Text(
job.company,
style: TextStyle(
color: Colors.grey.shade300,
fontSize: 17,
),
),
),

const SizedBox(height: 30),

_infoTile(
Icons.location_on,
"Location",
job.location,
),

_infoTile(
Icons.currency_rupee,
"Salary",
job.salary,
),

_infoTile(
Icons.work,
"Experience",
job.experience,
),

_infoTile(
Icons.badge,
"Job Type",
job.jobType,
),

_infoTile(
Icons.schedule,
"Posted",
job.postedDate,
),

const SizedBox(height: 24),

const Text(
"Required Skills",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 20,
),
),

const SizedBox(height: 15),

Wrap(
spacing: 10,
runSpacing: 10,
children: job.skills.map((skill) {
return Container(
padding:
const EdgeInsets.symmetric(
horizontal: 14,
vertical: 10,
),
decoration: BoxDecoration(
color: Colors.blue.withOpacity(.15),
borderRadius:
BorderRadius.circular(25),
),
child: Text(
skill,
style: const TextStyle(
color:
Colors.lightBlueAccent,
fontWeight:
FontWeight.bold,
),
),
);
}).toList(),
),

const SizedBox(height: 28),

const Text(
"Job Description",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Text(
job.description,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.7,
),
),

const SizedBox(height: 35),
  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: isApplying ? null : applyJob,
      icon: isApplying
          ? const SizedBox(
        height: 20,
        width: 20,
        child:
        CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : const Icon(
        Icons.send_rounded,
      ),
      label: Text(
        isApplying
            ? "Applying..."
            : "Apply Now",
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
        const Color(0xff2563EB),
        foregroundColor: Colors.white,
        elevation: 0,
        padding:
        const EdgeInsets.symmetric(
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),
      ),
    ),
  ),

  const SizedBox(height: 30),
],
),
),
);
}

Widget _infoTile(
    IconData icon,
    String title,
    String value,
    ) {
  return Container(
    margin: const EdgeInsets.only(
      bottom: 14,
    ),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.05),
      borderRadius:
      BorderRadius.circular(18),
      border: Border.all(
        color:
        Colors.white.withOpacity(.08),
      ),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.lightBlueAccent,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:
                  Colors.grey.shade400,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w600,
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