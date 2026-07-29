import 'package:flutter/material.dart';
import '../../models/hackathon_model.dart';
import '../../services/hackathon_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HackathonDetailsScreen extends StatelessWidget {
final Hackathon hackathon;

const HackathonDetailsScreen({
super.key,
required this.hackathon,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF0F172A),
appBar: AppBar(
title: const Text("Hackathon Details"),
backgroundColor: const Color(0xFF0F172A),
elevation: 0,
),
body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Hero(
tag: hackathon.id,
child: Image.network(
hackathon.banner,
height: 240,
width: double.infinity,
fit: BoxFit.cover,
),
),

Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
hackathon.title,
style: const TextStyle(
color: Colors.white,
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
hackathon.organizer,
style: TextStyle(
color: Colors.grey.shade400,
fontSize: 16,
),
),

const SizedBox(height: 24),

_infoTile(
Icons.emoji_events,
"Prize Pool",
hackathon.prizePool,
),

_infoTile(
Icons.people,
"Team Size",
hackathon.teamSize,
),

_infoTile(
Icons.public,
"Mode",
hackathon.mode,
),

_infoTile(
Icons.location_on,
"Location",
hackathon.location,
),

_infoTile(
Icons.calendar_today,
"Registration Deadline",
  DateFormat('dd MMM yyyy').format(
    DateTime.parse(hackathon.deadline),
  ),
),

_infoTile(
Icons.event,
"Event Date",
  hackathon.eventDate.isEmpty
      ? "Not Announced"
      : DateFormat('dd MMM yyyy').format(
    DateTime.parse(hackathon.eventDate),
  ),
),

const SizedBox(height: 24),

const Text(
"Technologies",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Wrap(
spacing: 10,
runSpacing: 10,
children: hackathon.technologies
.map(
(tech) => Chip(
label: Text(tech),
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

const SizedBox(height: 24),

const Text(
"Description",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(
hackathon.description,
style: TextStyle(
color: Colors.grey.shade300,
height: 1.6,
),
),

const SizedBox(height: 30),
  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
        onPressed: () async {
          try {
            await HackathonService().applyHackathon(hackathon.id);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Successfully registered for ${hackathon.title}",
                  ),
                ),
              );
            }
          } on DioException catch (e) {
            if (context.mounted) {
              final message = e.response?.data is Map
                  ? e.response?.data["message"] ?? "Registration failed"
                  : "Registration failed";

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          }
        },
      icon: const Icon(Icons.rocket_launch),
      label: const Text(
        "Register Now",
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