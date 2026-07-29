import 'package:flutter/material.dart';
import '../../models/internship_model.dart';
import 'package:intl/intl.dart';

class InternshipCard extends StatefulWidget {
  final Internship internship;
  final VoidCallback onTap;
  final VoidCallback? onApply;

  const InternshipCard({
    super.key,
    required this.internship,
    required this.onTap,
    this.onApply,
  });

  @override
  State<InternshipCard> createState() => _InternshipCardState();
}

class _InternshipCardState extends State<InternshipCard> {
bool isSaved = false;
bool isHovered = false;

@override
void initState() {
super.initState();
isSaved = widget.internship.isSaved;
}

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) {
setState(() {
isHovered = true;
});
},
onExit: (_) {
setState(() {
isHovered = false;
});
},
child: AnimatedContainer(
duration: const Duration(milliseconds: 250),
curve: Curves.easeInOut,
margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
const Color(0xff0f172a).withOpacity(.95),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
border: Border.all(
color: Colors.white.withOpacity(.08),
),
boxShadow: [
BoxShadow(
color: Colors.blue.withOpacity(.12),
blurRadius: isHovered ? 24 : 14,
spreadRadius: 2,
)
],
),
child: InkWell(
borderRadius: BorderRadius.circular(24),
onTap: widget.onTap,
child: Padding(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

/// ------------------------
/// Header
/// ------------------------

Row(
children: [

Hero(
tag: widget.internship.id,
child: Container(
height: 62,
width: 62,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(18),
color: Colors.white,
),
clipBehavior: Clip.antiAlias,
child: Image.network(
widget.internship.logo,
fit: BoxFit.cover,
),
),
),

const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
widget.internship.title,
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: Colors.white,
fontSize: 19,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 5),

Text(
widget.internship.company,
style: TextStyle(
color: Colors.grey.shade300,
fontSize: 15,
),
),
],
),
),

IconButton(
splashRadius: 22,
onPressed: () {
setState(() {
isSaved = !isSaved;
});
},
icon: AnimatedSwitcher(
duration:
const Duration(milliseconds: 300),
child: Icon(
isSaved
? Icons.favorite
: Icons.favorite_border,
key: ValueKey(isSaved),
color: isSaved
? Colors.red
: Colors.white,
),
),
),
],
),

const SizedBox(height: 22),

Wrap(
spacing: 18,
runSpacing: 10,
children: [

_infoChip(
Icons.location_on,
widget.internship.location,
),

_infoChip(
Icons.currency_rupee,
widget.internship.stipend,
),

_infoChip(
Icons.schedule,
widget.internship.duration,
),

_infoChip(
widget.internship.isRemote
? Icons.laptop_mac
: Icons.business,
widget.internship.isRemote
? "Remote"
: "On Site",
),
],
),

const SizedBox(height: 20),

Text(
widget.internship.description,
maxLines: 3,
overflow: TextOverflow.ellipsis,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.5,
),
),

const SizedBox(height: 20),

Wrap(
spacing: 10,
runSpacing: 10,
children: widget.internship.skills
.map(
(skill) => Container(
padding:
const EdgeInsets.symmetric(
horizontal: 14,
vertical: 8,
),
decoration: BoxDecoration(
color: Colors.blue
.withOpacity(.12),
borderRadius:
BorderRadius.circular(25),
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

const SizedBox(height: 25),
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
          onPressed: widget.onApply,
          icon: const Icon(
            Icons.send_rounded,
            size: 18,
          ),
          label: const Text("Apply"),
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
        Icons.calendar_today_rounded,
        color: Colors.orange,
        size: 18,
      ),

      const SizedBox(width: 8),

      Text(
        "Apply Before: ${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.internship.deadline))}",
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.w600,
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

Widget _infoChip(
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