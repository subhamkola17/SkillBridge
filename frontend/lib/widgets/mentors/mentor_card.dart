import 'package:flutter/material.dart';
import '../../models/mentor_model.dart';

class MentorCard extends StatefulWidget {
  final Mentor mentor;
  final VoidCallback onTap;
  final VoidCallback? onBookSession;

  const MentorCard({
    super.key,
    required this.mentor,
    required this.onTap,
    this.onBookSession,
  });

  @override
  State<MentorCard> createState() => _MentorCardState();
}

class _MentorCardState extends State<MentorCard> {
bool isSaved = false;
bool isHovered = false;

@override
void initState() {
super.initState();
isSaved = widget.mentor.isSaved;
}

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => isHovered = true),
onExit: (_) => setState(() => isHovered = false),
child: AnimatedContainer(
duration: const Duration(milliseconds: 250),
margin: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 10,
),
transform: Matrix4.identity()
..translate(
0.0,
isHovered ? -6.0 : 0.0,
),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(24),
gradient: LinearGradient(
colors: [
const Color(0xff172554).withOpacity(.95),
const Color(0xff0F172A).withOpacity(.95),
],
),
border: Border.all(
color: Colors.white.withOpacity(.08),
),
boxShadow: [
BoxShadow(
color: Colors.blue.withOpacity(.12),
blurRadius: isHovered ? 24 : 14,
),
],
),
child: InkWell(
borderRadius: BorderRadius.circular(24),
onTap: widget.onTap,
child: Padding(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Hero(
tag: widget.mentor.id,
child: CircleAvatar(
radius: 38,
  backgroundImage: null,
  child: const Icon(
      Icons.person,
      size: 35,
  ),
),
),

const SizedBox(width: 16),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
widget.mentor.name,
style: const TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(
widget.mentor.designation,
style: TextStyle(
color: Colors.grey.shade300,
),
),

const SizedBox(height: 4),

Text(
widget.mentor.company,
style: const TextStyle(
color: Colors.lightBlueAccent,
fontWeight: FontWeight.w600,
),
),
],
),
),

IconButton(
onPressed: () {
setState(() {
isSaved = !isSaved;
});
},
icon: Icon(
isSaved
? Icons.favorite
: Icons.favorite_border,
color: isSaved
? Colors.red
: Colors.white,
),
),
],
),

const SizedBox(height: 18),

Wrap(
spacing: 12,
runSpacing: 10,
children: [

_chip(
Icons.star,
widget.mentor.rating,
),

_chip(
Icons.work,
widget.mentor.experience,
),

_chip(
Icons.psychology,
widget.mentor.expertise,
),

_chip(
Icons.groups,
widget.mentor.sessions,
),
],
),

const SizedBox(height: 18),

Text(
widget.mentor.bio,
maxLines: 3,
overflow: TextOverflow.ellipsis,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.5,
),
),

const SizedBox(height: 18),

Wrap(
spacing: 10,
runSpacing: 10,
children: widget.mentor.skills
.map(
(skill) => Container(
padding:
const EdgeInsets.symmetric(
horizontal: 14,
vertical: 8,
),
decoration: BoxDecoration(
color:
Colors.blue.withOpacity(.12),
borderRadius:
BorderRadius.circular(25),
),
child: Text(
skill,
style: const TextStyle(
color:
Colors.lightBlueAccent,
fontWeight:
FontWeight.w600,
),
),
),
)
.toList(),
),

const SizedBox(height: 20),
  Row(
    children: [
      Expanded(
        child: OutlinedButton.icon(
          onPressed: widget.onTap,
          icon: const Icon(
            Icons.person_outline,
            size: 18,
          ),
          label: const Text("View Profile"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(
              color: Colors.white.withOpacity(.25),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: ElevatedButton.icon(
          onPressed: widget.onBookSession,
          icon: const Icon(
            Icons.calendar_month,
            size: 18,
          ),
          label: const Text("Book Session"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3B82F6),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    ],
  ),
],
),
),
),
),
);
}

Widget _chip(
    IconData icon,
    String text,
    ) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.05),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.lightBlueAccent,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}
}