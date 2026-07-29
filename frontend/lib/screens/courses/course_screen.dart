import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../widgets/courses/course_card.dart';
import '../../widgets/courses/course_filter_chip.dart';
import '../../widgets/courses/course_search_bar.dart';
import 'course_details_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
final TextEditingController _searchController =
TextEditingController();

final List<String> filters = [
"All",
"Flutter",
"Web",
"AI/ML",
"Backend",
"Cloud",
"Beginner",
"Advanced",
];

String selectedFilter = "All";

late List<Course> courses;

@override
void initState() {
super.initState();

courses = [
Course(
id: "1",
title: "Complete Flutter Development",
instructor: "Angela Yu",
category: "Flutter",
duration: "42 Hours",
level: "Beginner",
rating: "4.9",
students: "120K",
thumbnail:
"https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=1200",
description:
"Learn Flutter from scratch and build beautiful cross-platform mobile applications.",
skills: [
"Flutter",
"Dart",
"Firebase",
],
),

Course(
id: "2",
title: "Machine Learning Bootcamp",
instructor: "Andrew Ng",
category: "AI/ML",
duration: "60 Hours",
level: "Advanced",
rating: "4.8",
students: "210K",
thumbnail:
"https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=1200",
description:
"Master AI, Machine Learning and Deep Learning using Python.",
skills: [
"Python",
"TensorFlow",
"Machine Learning",
],
),

Course(
id: "3",
title: "Node.js Backend Masterclass",
instructor: "Maximilian",
category: "Backend",
duration: "35 Hours",
level: "Intermediate",
rating: "4.7",
students: "90K",
thumbnail:
"https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=1200",
description:
"Learn Node.js, Express, MongoDB and REST API development.",
skills: [
"Node.js",
"Express",
"MongoDB",
],
),
];
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0F172A),

appBar: AppBar(
title: const Text("Courses"),
backgroundColor: Colors.transparent,
elevation: 0,
centerTitle: true,
),

body: Column(
children: [

CourseSearchBar(
controller: _searchController,
onChanged: (_) {
setState(() {});
},
),

SizedBox(
height: 52,
child: ListView.builder(
padding:
const EdgeInsets.symmetric(horizontal: 16),
scrollDirection: Axis.horizontal,
itemCount: filters.length,
itemBuilder: (context, index) {
return CourseFilterChip(
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
    child: RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        setState(() {});
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          if (_searchController.text.isNotEmpty &&
              !course.title.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) &&
              !course.instructor.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              )) {
            return const SizedBox.shrink();
          }

          if (selectedFilter != "All") {
            final categoryMatch =
                course.category.toLowerCase() ==
                    selectedFilter.toLowerCase();

            final levelMatch =
                course.level.toLowerCase() ==
                    selectedFilter.toLowerCase();

            if (!categoryMatch && !levelMatch) {
              return const SizedBox.shrink();
            }
          }

          return CourseCard(
            course: course,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CourseDetailsScreen(
                        course: course,
                      ),
                ),
              );
            },
            onEnroll: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    "Enrolled in ${course.title}",
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