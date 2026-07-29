import 'package:flutter/material.dart';

import '../../widgets/mentor_booking/calendar_widget.dart';
import '../../widgets/mentor_booking/mentor_header_card.dart';
import '../../widgets/mentor_booking/notes_box.dart';
import '../../widgets/mentor_booking/session_type_card.dart';
import '../../widgets/mentor_booking/time_slot_chip.dart';
import 'booking_success_screen.dart';
import '../../models/mentor_model.dart';
import '../../models/booking_model.dart';
import 'dart:math';
import '../../services/booking_service.dart';

class BookSessionScreen extends StatefulWidget {
  final Mentor mentor;

  const BookSessionScreen({
    super.key,
    required this.mentor,
  });

  @override
  State<BookSessionScreen> createState() =>
      _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  final BookingService _bookingService = BookingService();

  bool isLoading = false;
DateTime selectedDate = DateTime.now();

String selectedTime = "10:00 AM";
String selectedSession = "Video";
int selectedDuration = 60;

final TextEditingController notesController =
TextEditingController();

final List<String> timeSlots = [
"09:00 AM",
"10:00 AM",
"11:30 AM",
"02:00 PM",
"04:00 PM",
"06:30 PM",
];

@override
void dispose() {
notesController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
const mentorFee = 799;
const platformFee = 49;

return Scaffold(
backgroundColor: const Color(0xFF0B1120),

appBar: AppBar(
backgroundColor: const Color(0xFF0B1120),
elevation: 0,
centerTitle: true,
title: const Text(
"Book Session",
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

  MentorHeaderCard(
    name: widget.mentor.name,
    designation: widget.mentor.designation,
    company: widget.mentor.company,
    rating: double.parse(widget.mentor.rating),
    experience: int.parse(
      widget.mentor.experience.split(" ").first,
    ),
    sessions: int.parse(
      widget.mentor.sessions.replaceAll("+", ""),
    ),
    price: mentorFee,
    imageUrl: widget.mentor.image,
  ),

const SizedBox(height: 28),

const Text(
"Select Date",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

CalendarWidget(
selectedDate: selectedDate,
onDateSelected: (date) {
setState(() {
selectedDate = date;
});
},
),

const SizedBox(height: 28),
const Text(
"Available Time Slots",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Wrap(
spacing: 12,
runSpacing: 12,
children: timeSlots.map((slot) {
return TimeSlotChip(
time: slot,
isSelected: selectedTime == slot,
onTap: () {
setState(() {
selectedTime = slot;
});
},
);
}).toList(),
),

const SizedBox(height: 30),

const Text(
"Session Type",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

SessionTypeCard(
icon: Icons.videocam_rounded,
title: "Video Call",
subtitle: "Face-to-face mentoring session",
isSelected: selectedSession == "Video",
onTap: () {
setState(() {
selectedSession = "Video";
});
},
),

const SizedBox(height: 12),

SessionTypeCard(
icon: Icons.call_rounded,
title: "Audio Call",
subtitle: "Voice discussion only",
isSelected: selectedSession == "Audio",
onTap: () {
setState(() {
selectedSession = "Audio";
});
},
),

const SizedBox(height: 12),

SessionTypeCard(
icon: Icons.chat_bubble_rounded,
title: "Chat Session",
subtitle: "Text based mentoring",
isSelected: selectedSession == "Chat",
onTap: () {
setState(() {
selectedSession = "Chat";
});
},
),

const SizedBox(height: 30),

const Text(
"Session Duration",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Wrap(
spacing: 12,
children: [

_durationChip(30),

_durationChip(60),

_durationChip(90),

],
),

const SizedBox(height: 30),

NotesBox(
controller: notesController,
),

const SizedBox(height: 30),
  const Text(
    "Booking Summary",
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 15),

  Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF151B2E),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withOpacity(.08),
      ),
    ),
    child: Column(
      children: [

        _summaryRow(
          "Session Fee",
          "₹$mentorFee",
        ),

        const SizedBox(height: 12),

        _summaryRow(
          "Platform Fee",
          "₹$platformFee",
        ),

        const Divider(
          color: Colors.white24,
          height: 30,
        ),

        _summaryRow(
          "Date",
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        ),

        const SizedBox(height: 12),

        _summaryRow(
          "Time",
          selectedTime,
        ),

        const SizedBox(height: 12),

        _summaryRow(
          "Duration",
          "$selectedDuration Minutes",
        ),

        const Divider(
          color: Colors.white24,
          height: 30,
        ),

        _summaryRow(
          "Total",
          "₹${mentorFee + platformFee}",
          isTotal: true,
        ),
      ],
    ),
  ),

  const SizedBox(height: 35),

  SizedBox(
    width: double.infinity,
    height: 58,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onPressed: isLoading
          ? null
          : () async {
        setState(() {
          isLoading = true;
        });

        try {
          final response =
          await _bookingService.createBooking(
            mentorId: widget.mentor.id,
            bookingDate:
            selectedDate.toIso8601String(),
            timeSlot: selectedTime,
            duration: selectedDuration,
            sessionType: selectedSession,
            notes: notesController.text,
            amount:
            (mentorFee + platformFee).toDouble(),
          );



          final booking = BookingModel(
            id: response["booking"]["_id"],
            mentor: widget.mentor,
            date: selectedDate,
            time: selectedTime,
            duration: selectedDuration,
            sessionType: selectedSession,
            notes: notesController.text,
            amount: mentorFee + platformFee,
            meetingId:
            response["booking"]["meetingId"],
          );

          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  BookingSuccessScreen(
                    booking: booking,
                  ),
            ),
          );
        } catch (e) {
          if (!mounted) return;

          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        } finally {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : const Text(
        "Book Session",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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

Widget _durationChip(int minutes) {
  final selected = selectedDuration == minutes;

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedDuration = minutes;
      });
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF2563EB)
            : const Color(0xFF151B2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected
              ? Colors.transparent
              : Colors.white.withOpacity(.08),
        ),
      ),
      child: Text(
        "$minutes Minutes",
        style: TextStyle(
          color: selected
              ? Colors.white
              : Colors.grey.shade300,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _summaryRow(
    String title,
    String value, {
      bool isTotal = false,
    }) {
  return Row(
    children: [

      Text(
        title,
        style: TextStyle(
          color: isTotal
              ? Colors.white
              : Colors.grey.shade400,
          fontSize: isTotal ? 18 : 15,
          fontWeight: isTotal
              ? FontWeight.bold
              : FontWeight.w500,
        ),
      ),

      const Spacer(),

      Text(
        value,
        style: TextStyle(
          color: isTotal
              ? Colors.greenAccent
              : Colors.white,
          fontSize: isTotal ? 20 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
String _generateMeetingId() {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

  final random = Random();

  return "SB-${List.generate(
    6,
        (_) => chars[random.nextInt(chars.length)],
  ).join()}";
}
}