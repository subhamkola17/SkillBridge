import 'package:flutter/material.dart';
import '../../models/hackathon_model.dart';
import 'package:intl/intl.dart';

class HackathonCard extends StatefulWidget {
  final Hackathon hackathon;
  final VoidCallback onTap;
  final VoidCallback? onRegister;

  const HackathonCard({
    super.key,
    required this.hackathon,
    required this.onTap,
    this.onRegister,
  });

  @override
  State<HackathonCard> createState() => _HackathonCardState();
}

class _HackathonCardState extends State<HackathonCard> {
bool isSaved = false;
bool isHovered = false;

@override
void initState() {
super.initState();
isSaved = widget.hackathon.isSaved;
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
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Hero(
tag: widget.hackathon.id,
child: ClipRRect(
borderRadius: const BorderRadius.vertical(
top: Radius.circular(24),
),
child: Image.network(
widget.hackathon.banner,
height: 180,
width: double.infinity,
fit: BoxFit.cover,
),
),
),

Padding(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Row(
children: [

Expanded(
child: Text(
widget.hackathon.title,
style: const TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
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

const SizedBox(height: 6),

Text(
widget.hackathon.organizer,
style: TextStyle(
color: Colors.grey.shade300,
),
),

const SizedBox(height: 16),

Wrap(
spacing: 12,
runSpacing: 10,
children: [

_chip(
Icons.emoji_events,
widget.hackathon.prizePool,
),

_chip(
Icons.people,
widget.hackathon.teamSize,
),

_chip(
Icons.public,
widget.hackathon.mode,
),

_chip(
Icons.location_on,
widget.hackathon.location,
),
],
),

const SizedBox(height: 18),

Text(
widget.hackathon.description,
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
children: widget.hackathon.technologies
.map(
(tech) => Container(
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
tech,
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
            Icons.visibility_outlined,
            size: 18,
          ),
          label: const Text("View Details"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(
              color: Colors.white.withOpacity(.25),
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(14),
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
          onPressed: widget.onRegister,
          icon: const Icon(
            Icons.rocket_launch,
            size: 18,
          ),
          label: const Text("Register"),
          style: ElevatedButton.styleFrom(
            backgroundColor:
            const Color(0xff3B82F6),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    ],
  ),

  const SizedBox(height: 18),

  Row(
    children: [
      const Icon(
        Icons.calendar_today,
        color: Colors.orange,
        size: 18,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          "Registration Ends: ${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.hackathon.deadline))}",
          style: const TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),

  const SizedBox(height: 10),

  Row(
    children: [
      const Icon(
        Icons.event,
        color: Colors.green,
        size: 18,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          "Event Date: ${widget.hackathon.eventDate.isEmpty ? 'Not Announced' : DateFormat('dd MMM yyyy').format(DateTime.parse(widget.hackathon.eventDate))}",
          style: const TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),
],
),
),
],
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