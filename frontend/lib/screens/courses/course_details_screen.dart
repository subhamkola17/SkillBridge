import 'package:flutter/material.dart';
import '../../models/course_model.dart';

class CourseDetailsScreen extends StatelessWidget {
final Course course;

const CourseDetailsScreen({
super.key,
required this.course,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
title: const Text("Course Details"),
),

body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Hero(
tag: course.id,
child: ClipRRect(
borderRadius: const BorderRadius.only(
bottomLeft: Radius.circular(28),
bottomRight: Radius.circular(28),
),
child: Image.network(
course.thumbnail,
height: 240,
width: double.infinity,
fit: BoxFit.cover,
),
),
),

Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
course.title,
style: const TextStyle(
color: Colors.white,
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
"Instructor: ${course.instructor}",
style: TextStyle(
color: Colors.grey.shade300,
fontSize: 16,
),
),

const SizedBox(height: 22),

_infoTile(
Icons.category,
"Category",
course.category,
),

_infoTile(
Icons.schedule,
"Duration",
course.duration,
),

_infoTile(
Icons.school,
"Level",
course.level,
),

_infoTile(
Icons.star,
"Rating",
course.rating,
),

_infoTile(
Icons.people,
"Students",
course.students,
),

const SizedBox(height: 25),

const Text(
"Skills You'll Learn",
style: TextStyle(
color: Colors.white,
fontSize: 21,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Wrap(
spacing: 10,
runSpacing: 10,
children: course.skills.map((skill) {
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
fontWeight: FontWeight.bold,
),
),
);
}).toList(),
),

const SizedBox(height: 28),

const Text(
"Course Description",
style: TextStyle(
color: Colors.white,
fontSize: 21,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Text(
course.description,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.7,
),
),

const SizedBox(height: 35),
  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Successfully enrolled in ${course.title}",
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      icon: const Icon(Icons.school),
      label: const Text("Enroll Now"),
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