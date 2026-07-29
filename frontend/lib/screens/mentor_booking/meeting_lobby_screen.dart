import 'package:flutter/material.dart';

import '../../models/booking_model.dart';
import 'live_meeting_screen.dart';


class MeetingLobbyScreen extends StatefulWidget {
  final BookingModel booking;

  const MeetingLobbyScreen({
    super.key,
    required this.booking,
  });

  @override
  State<MeetingLobbyScreen> createState() =>
      _MeetingLobbyScreenState();
}

class _MeetingLobbyScreenState
    extends State<MeetingLobbyScreen> {

bool micOn = true;
bool cameraOn = true;
bool speakerOn = true;

@override
Widget build(BuildContext context) {

return Scaffold(
backgroundColor: const Color(0xFF0B1120),

appBar: AppBar(
backgroundColor: const Color(0xFF0B1120),
elevation: 0,
centerTitle: true,
title: const Text(
"Meeting Lobby",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),

body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Container(
width: double.infinity,
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: const Color(0xFF151B2E),
borderRadius:
BorderRadius.circular(22),
),
child: Row(
children: [

  CircleAvatar(
    radius: 32,
    backgroundColor: Colors.grey,
    backgroundImage: null,
    child: const Icon(
      Icons.person,
      size: 32,
      color: Colors.white,
    ),
  ),

const SizedBox(width: 15),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
widget.booking.mentor.name,
style: const TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(
widget.booking.mentor.company,
style: const TextStyle(
color: Colors.grey,
),
),

const SizedBox(height: 8),

Container(
padding:
const EdgeInsets.symmetric(
horizontal: 10,
vertical: 5,
),
decoration: BoxDecoration(
color: Colors.green
.withOpacity(.15),
borderRadius:
BorderRadius.circular(
20),
),
child: const Text(
"Waiting to Join",
style: TextStyle(
color: Colors.green,
fontWeight:
FontWeight.bold,
),
),
),
],
),
),
],
),
),

const SizedBox(height: 25),

const Text(
"Meeting Preview",
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Container(
width: double.infinity,
height: 250,
decoration: BoxDecoration(
color: Colors.black,
borderRadius:
BorderRadius.circular(22),
),
child: Stack(
children: [

const Center(
child: Icon(
Icons.videocam,
size: 80,
color: Colors.white24,
),
),

Positioned(
right: 15,
bottom: 15,
child: Container(
width: 110,
height: 150,
decoration: BoxDecoration(
color:
Colors.grey.shade900,
borderRadius:
BorderRadius.circular(
16),
),
child: const Center(
child: Icon(
Icons.person,
color: Colors.white38,
size: 50,
),
),
),
),

],
),
),

const SizedBox(height: 25),

Container(
padding:
const EdgeInsets.all(18),
decoration: BoxDecoration(
color: const Color(0xFF151B2E),
borderRadius:
BorderRadius.circular(20),
),
child: Column(
children: [

_infoTile(
Icons.calendar_today,
"Date",
"${widget.booking.date.day}/${widget.booking.date.month}/${widget.booking.date.year}",
),

const Divider(
color: Colors.white24,
),

_infoTile(
Icons.access_time,
"Time",
widget.booking.time,
),

const Divider(
color: Colors.white24,
),

_infoTile(
Icons.timer,
"Duration",
"${widget.booking.duration} Minutes",
),

const Divider(
color: Colors.white24,
),

_infoTile(
Icons.confirmation_number,
"Meeting ID",
widget.booking.meetingId ?? '',
),

],
),
),

const SizedBox(height: 30),
const Text(
"Device Controls",
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 18),

Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [

_controlButton(
icon: micOn ? Icons.mic : Icons.mic_off,
label: "Mic",
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
label: "Camera",
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
label: "Speaker",
enabled: speakerOn,
onTap: () {
setState(() {
speakerOn = !speakerOn;
});
},
),

],
),

const SizedBox(height: 30),

Container(
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: const Color(0xFF151B2E),
borderRadius: BorderRadius.circular(20),
),
child: Row(
children: [

const CircleAvatar(
radius: 22,
backgroundColor: Colors.green,
child: Icon(
Icons.wifi,
color: Colors.white,
),
),

const SizedBox(width: 15),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

const Text(
"Network Status",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),

Text(
"Excellent connection",
style: TextStyle(
color: Colors.grey.shade400,
),
),
],
),
),

const Text(
"98%",
style: TextStyle(
color: Colors.green,
fontWeight: FontWeight.bold,
fontSize: 18,
),
),

],
),
),

const SizedBox(height: 25),

Container(
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: const Color(0xFF151B2E),
borderRadius: BorderRadius.circular(20),
),
child: const Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Row(
children: [

Icon(
Icons.smart_toy,
color: Colors.lightBlueAccent,
),

SizedBox(width: 10),

Text(
"AI Meeting Tips",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 18,
),
),
],
),

SizedBox(height: 15),

Text(
"• Join from a quiet place.",
style: TextStyle(
color: Colors.white70,
),
),

SizedBox(height: 8),

Text(
"• Test your microphone before joining.",
style: TextStyle(
color: Colors.white70,
),
),

SizedBox(height: 8),

Text(
"• Keep your resume ready for discussion.",
style: TextStyle(
color: Colors.white70,
),
),

SizedBox(height: 8),

Text(
"• Ensure a stable internet connection.",
style: TextStyle(
color: Colors.white70,
),
),

],
),
),

const SizedBox(height: 35),
  SizedBox(
    width: double.infinity,
    height: 58,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>  LiveMeetingScreen(),
          ),
        );
      },
      icon: const Icon(Icons.video_call),
      label: const Text(
        "Join Meeting",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const SizedBox(height: 15),

  SizedBox(
    width: double.infinity,
    height: 55,
    child: OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.call_end,
        color: Colors.red,
      ),
      label: const Text(
        "Cancel",
        style: TextStyle(
          color: Colors.red,
          fontSize: 17,
        ),
      ),
    ),
  ),

  const SizedBox(height: 30),

],
),
),
),
);
}

Widget _controlButton({
  required IconData icon,
  required String label,
  required bool enabled,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [

        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled
                ? const Color(0xFF2563EB)
                : Colors.red,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

      ],
    ),
  );
}

Widget _infoTile(
    IconData icon,
    String title,
    String value,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
    ),
    child: Row(
      children: [

        Icon(
          icon,
          color: Colors.lightBlueAccent,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    ),
  );
}
}