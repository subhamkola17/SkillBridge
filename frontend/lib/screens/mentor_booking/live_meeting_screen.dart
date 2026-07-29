import 'dart:async';
import 'feedback_screen.dart';

import 'package:flutter/material.dart';

class LiveMeetingScreen extends StatefulWidget {
  const LiveMeetingScreen({super.key});

  @override
  State<LiveMeetingScreen> createState() => _LiveMeetingScreenState();
}

class _LiveMeetingScreenState extends State<LiveMeetingScreen> {
bool micOn = true;
bool cameraOn = true;
bool speakerOn = true;

late Timer timer;
int seconds = 0;

@override
void initState() {
super.initState();

timer = Timer.periodic(
const Duration(seconds: 1),
(_) {
if (mounted) {
setState(() {
seconds++;
});
}
},
);
}

@override
void dispose() {
timer.cancel();
super.dispose();
}

String get meetingTime {
final h = (seconds ~/ 3600).toString().padLeft(2, '0');
final m = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
final s = (seconds % 60).toString().padLeft(2, '0');

return "$h:$m:$s";
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,

body: SafeArea(
child: Stack(
children: [

/// Mentor Video
Positioned.fill(
child: Container(
color: Colors.black,
child: const Center(
child: Icon(
Icons.person,
color: Colors.white24,
size: 180,
),
),
),
),

/// Top Bar
Positioned(
top: 18,
left: 20,
right: 20,
child: Row(
children: [

Container(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
decoration: BoxDecoration(
color: Colors.red,
borderRadius: BorderRadius.circular(20),
),
child: const Text(
"LIVE",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(width: 12),

Text(
meetingTime,
style: const TextStyle(
color: Colors.white,
fontSize: 17,
fontWeight: FontWeight.bold,
),
),

const Spacer(),

const Icon(
Icons.signal_cellular_alt,
color: Colors.green,
),

const SizedBox(width: 6),

const Text(
"Excellent",
style: TextStyle(
color: Colors.white,
),
),
],
),
),

/// Self Preview
Positioned(
top: 80,
right: 18,
child: Container(
width: 120,
height: 170,
decoration: BoxDecoration(
color: Colors.grey.shade900,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: Colors.white24,
),
),
child: const Center(
child: Icon(
Icons.person,
color: Colors.white38,
size: 55,
),
),
),
),

/// Mentor Name
Positioned(
bottom: 140,
left: 20,
child: Container(
padding: const EdgeInsets.symmetric(
horizontal: 14,
vertical: 8,
),
decoration: BoxDecoration(
color: Colors.black54,
borderRadius: BorderRadius.circular(20),
),
child: const Text(
"Mentor",
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
),
/// Mentor Details Card
Positioned(
left: 20,
right: 20,
bottom: 210,
child: Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.black.withOpacity(.65),
borderRadius: BorderRadius.circular(20),
border: Border.all(
color: Colors.white12,
),
),
child: Row(
children: [

const CircleAvatar(
radius: 28,
backgroundColor: Color(0xFF2563EB),
child: Icon(
Icons.school,
color: Colors.white,
),
),

const SizedBox(width: 15),

const Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"Career Mentorship Session",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 17,
),
),

SizedBox(height: 4),

Text(
"1 : 1 Live Video Meeting",
style: TextStyle(
color: Colors.white70,
),
),

],
),
),

Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 6,
),
decoration: BoxDecoration(
color: Colors.green.withOpacity(.2),
borderRadius:
BorderRadius.circular(20),
),
child: const Text(
"Connected",
style: TextStyle(
color: Colors.greenAccent,
fontWeight: FontWeight.bold,
),
),
),

],
),
),
),

/// AI Assistant Card
Positioned(
left: 20,
right: 20,
bottom: 320,
child: Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xFF2563EB),
Color(0xFF1E40AF),
],
),
borderRadius:
BorderRadius.circular(20),
),
child: const Row(
children: [

CircleAvatar(
backgroundColor: Colors.white,
child: Icon(
Icons.smart_toy,
color: Color(0xFF2563EB),
),
),

SizedBox(width: 15),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
"AI Meeting Assistant",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 4),

Text(
"AI can summarize this meeting and generate notes.",
style: TextStyle(
color: Colors.white70,
fontSize: 13,
),
),

],
),
),

],
),
),
),

/// Quick Notes Button
Positioned(
top: 270,
right: 20,
child: FloatingActionButton.small(
heroTag: "notes",
backgroundColor: const Color(0xFF2563EB),
onPressed: () {},
child: const Icon(
Icons.note_alt_outlined,
color: Colors.white,
),
),
),

/// Chat Button
Positioned(
top: 330,
right: 20,
child: FloatingActionButton.small(
heroTag: "chat",
backgroundColor: Colors.deepPurple,
onPressed: () {},
child: const Icon(
Icons.chat_bubble_outline,
color: Colors.white,
),
),
),

/// AI Assistant Button
Positioned(
top: 390,
right: 20,
child: FloatingActionButton.small(
heroTag: "ai",
backgroundColor: Colors.orange,
onPressed: () {},
child: const Icon(
Icons.auto_awesome,
color: Colors.white,
),
),
),
/// Bottom Controls
Positioned(
bottom: 25,
left: 15,
right: 15,
child: Container(
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 14,
),
decoration: BoxDecoration(
color: Colors.black.withOpacity(.80),
borderRadius: BorderRadius.circular(30),
border: Border.all(
color: Colors.white12,
),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [

_controlButton(
icon: micOn
? Icons.mic
: Icons.mic_off,
enabled: micOn,
onTap: () {
setState(() {
micOn = !micOn;
});
},
),

_controlButton(
icon: cameraOn
? Icons.videocam
: Icons.videocam_off,
enabled: cameraOn,
onTap: () {
setState(() {
cameraOn = !cameraOn;
});
},
),

_controlButton(
icon: speakerOn
? Icons.volume_up
: Icons.volume_off,
enabled: speakerOn,
onTap: () {
setState(() {
speakerOn = !speakerOn;
});
},
),

_controlButton(
icon: Icons.cameraswitch,
enabled: true,
onTap: () {},
),

_controlButton(
icon: Icons.favorite,
enabled: true,
onTap: () {},
),

GestureDetector(
onTap: () {
_showEndMeetingDialog();
},
child: Container(
width: 62,
height: 62,
decoration: const BoxDecoration(
color: Colors.red,
shape: BoxShape.circle,
),
child: const Icon(
Icons.call_end,
color: Colors.white,
size: 32,
),
),
),

],
),
),
),

],
),
),
);
}

Widget _controlButton({
required IconData icon,
required bool enabled,
required VoidCallback onTap,
}) {
return GestureDetector(
onTap: onTap,
child: AnimatedContainer(
duration: const Duration(milliseconds: 250),
width: 54,
height: 54,
decoration: BoxDecoration(
color: enabled
? const Color(0xFF1E293B)
: Colors.red,
shape: BoxShape.circle,
),
child: Icon(
icon,
color: Colors.white,
size: 26,
),
),
);
}
void _showEndMeetingDialog() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xFF151B2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        "End Meeting?",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        "Are you sure you want to end this mentorship session?",
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Meeting Ended Successfully",
                ),
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const FeedbackScreen(),
              ),
            );
          },
          icon: const Icon(Icons.call_end),
          label: const Text("End"),
        ),

      ],
    ),
  );
}
}