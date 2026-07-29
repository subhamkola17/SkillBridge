import 'package:flutter/material.dart';

import '../../models/internship_model.dart';
import 'package:dio/dio.dart';
import '../../services/internship_service.dart';
import 'package:intl/intl.dart';

class InternshipDetailsScreen extends StatefulWidget {
final Internship internship;

const InternshipDetailsScreen({
super.key,
required this.internship,
});

@override
State<InternshipDetailsScreen> createState() =>
    _InternshipDetailsScreenState();
}

class _InternshipDetailsScreenState
    extends State<InternshipDetailsScreen> {

  bool isApplying = false;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
),

body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Center(
child: Hero(
tag: widget.internship.id,
child: Container(
height: 100,
width: 100,
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(22),
),
child: Image.network(
  widget.internship.logo,
fit: BoxFit.contain,
),
),
),
),

const SizedBox(height: 25),

Center(
child: Text(
  widget.internship.title,

textAlign: TextAlign.center,
style: const TextStyle(
color: Colors.white,
fontSize: 26,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 10),

Center(
child: Text(
  widget.internship.company,
style: TextStyle(
color: Colors.grey.shade400,
fontSize: 18,
),
),
),

const SizedBox(height: 30),

_infoTile(
Icons.location_on,
"Location",
  widget.internship.location,
),

_infoTile(
Icons.currency_rupee,
"Stipend",
  widget.internship.stipend,
),

_infoTile(
Icons.schedule,
"Duration",
  widget.internship.duration,
),

_infoTile(
Icons.calendar_today,
"Deadline",
    'Apply Before: ${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.internship.deadline))}'
),

_infoTile(
  widget.internship.isRemote
? Icons.laptop
: Icons.business,
"Mode",
  widget.internship.isRemote
? "Remote"
: "On Site",
),

const SizedBox(height: 28),

const Text(
"Required Skills",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 14),

Wrap(
spacing: 10,
runSpacing: 10,
children: widget.internship.skills
.map(
(skill) => Container(
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 10,
),
decoration: BoxDecoration(
color: Colors.blue.withOpacity(.15),
borderRadius:
BorderRadius.circular(30),
),
child: Text(
skill,
style: const TextStyle(
color: Colors.lightBlueAccent,
fontWeight: FontWeight.w600,
),
),
),
)
.toList(),
),

const SizedBox(height: 30),

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
  widget.internship.description,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.7,
fontSize: 15,
),
),

const SizedBox(height: 40),
  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Application submitted for ${widget.internship.title}",
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      icon: const Icon(Icons.send_rounded),
      label: const Text(
        "Apply Now",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2563EB),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.05),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.white.withOpacity(.08),
      ),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.blue.withOpacity(.15),
          child: Icon(
            icon,
            color: Colors.lightBlueAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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