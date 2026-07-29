import 'package:flutter/material.dart';
import '../../models/mentor_model.dart';

import '../mentor_booking/book_session_screen.dart';

class MentorDetailsScreen extends StatelessWidget {
final Mentor mentor;

const MentorDetailsScreen({
super.key,
required this.mentor,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF0F172A),
appBar: AppBar(
title: const Text("Mentor Details"),
backgroundColor: const Color(0xFF0F172A),
elevation: 0,
),
body: SingleChildScrollView(
child: Column(
children: [

const SizedBox(height: 20),

Hero(
tag: mentor.id,
child: CircleAvatar(
  radius: 70,
  backgroundColor: Colors.blue.shade700,
  child: Text(
    mentor.name[0],
    style: const TextStyle(
      fontSize: 42,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
),

const SizedBox(height: 20),

Text(
mentor.name,
style: const TextStyle(
color: Colors.white,
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
mentor.designation,
style: TextStyle(
color: Colors.grey.shade300,
fontSize: 18,
),
),

const SizedBox(height: 4),

Text(
mentor.company,
style: const TextStyle(
color: Colors.lightBlueAccent,
fontSize: 18,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 28),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Column(
children: [

_infoTile(
Icons.star,
"Rating",
mentor.rating,
),

_infoTile(
Icons.work,
"Experience",
mentor.experience,
),

_infoTile(
Icons.psychology,
"Expertise",
mentor.expertise,
),

_infoTile(
Icons.groups,
"Sessions",
mentor.sessions,
),

const SizedBox(height: 25),

const Align(
alignment: Alignment.centerLeft,
child: Text(
"Skills",
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 12),

Wrap(
spacing: 10,
runSpacing: 10,
children: mentor.skills
.map(
(skill) => Chip(
label: Text(skill),
backgroundColor:
Colors.blue.shade700,
labelStyle:
const TextStyle(
color: Colors.white,
),
),
)
.toList(),
),

const SizedBox(height: 25),

const Align(
alignment: Alignment.centerLeft,
child: Text(
"About Mentor",
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 10),

Text(
mentor.bio,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.6,
),
),

const SizedBox(height: 30),
  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookSessionScreen(
              mentor: mentor,
            ),
          ),
        );
      },
      icon: const Icon(Icons.calendar_month),
      label: const Text(
        "Book Session",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff3B82F6),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
],
),
),
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
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
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
        const SizedBox(width: 14),
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