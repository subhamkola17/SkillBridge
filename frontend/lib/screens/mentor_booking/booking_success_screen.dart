import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/booking_model.dart';
import 'meeting_lobby_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
final BookingModel booking;

const BookingSuccessScreen({
super.key,
required this.booking,
});

@override
Widget build(BuildContext context) {
final formattedDate =
DateFormat('dd MMMM yyyy').format(booking.date);

return Scaffold(
backgroundColor: const Color(0xFF0B1120),

body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.all(24),
child: Column(
children: [

const SizedBox(height: 20),

Container(
width: 120,
height: 120,
decoration: BoxDecoration(
color: Colors.green.withOpacity(.15),
shape: BoxShape.circle,
),
child: const Icon(
Icons.check_circle,
color: Colors.green,
size: 82,
),
),

const SizedBox(height: 28),

const Text(
"Booking Confirmed!",
style: TextStyle(
color: Colors.white,
fontSize: 30,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(
"Your mentorship session has been booked successfully.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.grey.shade400,
fontSize: 16,
),
),

const SizedBox(height: 35),

Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: const Color(0xFF151B2E),
borderRadius: BorderRadius.circular(22),
),
child: Column(
children: [

  CircleAvatar(
    radius: 40,
    backgroundColor: Colors.grey.shade300,
    child: const Icon(
      Icons.person,
      size: 40,
      color: Colors.black54,
    ),
  ),
const SizedBox(height: 15),

Text(
booking.mentor.name,
style: const TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 5),

Text(
"${booking.mentor.designation} • ${booking.mentor.company}",
textAlign: TextAlign.center,
style: const TextStyle(
color: Colors.grey,
fontSize: 15,
),
),

const SizedBox(height: 25),

_infoRow(
"Date",
formattedDate,
),

const Divider(color: Colors.white24),

_infoRow(
"Time",
booking.time,
),

const Divider(color: Colors.white24),

_infoRow(
"Duration",
"${booking.duration} Minutes",
),

const Divider(color: Colors.white24),

_infoRow(
"Session Type",
booking.sessionType,
),

const Divider(color: Colors.white24),

_infoRow(
"Meeting ID",
booking.meetingId ?? '',
),

const Divider(color: Colors.white24),

_infoRow(
"Total Amount",
"₹${booking.amount}",
),

if (booking.notes.trim().isNotEmpty) ...[

const Divider(color: Colors.white24),

_infoRow(
"Notes",
booking.notes,
),

],

],
),
),

const SizedBox(height: 30),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MeetingLobbyScreen(
              booking: booking,
            ),
          ),
        );
      },
      icon: const Icon(Icons.video_call),
      label: const Text(
        "Go to Meeting Lobby",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const SizedBox(height: 15),

  TextButton.icon(
    onPressed: () {
      Navigator.popUntil(
        context,
            (route) => route.isFirst,
      );
    },
    icon: const Icon(
      Icons.home,
      color: Colors.white70,
    ),
    label: const Text(
      "Back to Home",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    ),
  ),

  const SizedBox(height: 25),
],
),
),
),
);
}

Widget _infoRow(
    String title,
    String value,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}
}