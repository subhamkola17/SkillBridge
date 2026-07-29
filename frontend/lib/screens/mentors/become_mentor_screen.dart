import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/mentor_service.dart';
import 'mentor_dashboard_screen.dart';
class BecomeMentorScreen extends StatefulWidget {
  const BecomeMentorScreen({super.key});

  @override
  State<BecomeMentorScreen> createState() =>
      _BecomeMentorScreenState();
}

class _BecomeMentorScreenState
    extends State<BecomeMentorScreen> {
final _formKey = GlobalKey<FormState>();

final _nameController = TextEditingController();
final _designationController = TextEditingController();
final _companyController = TextEditingController();
final _expertiseController = TextEditingController();
final _experienceController = TextEditingController();
final _bioController = TextEditingController();
final _skillsController = TextEditingController();
final _languagesController = TextEditingController();
final _feeController = TextEditingController();
final _linkedinController = TextEditingController();
final _daysController = TextEditingController();
final _slotsController = TextEditingController();

bool loading = false;

@override
void dispose() {
_nameController.dispose();
_designationController.dispose();
_companyController.dispose();
_expertiseController.dispose();
_experienceController.dispose();
_bioController.dispose();
_skillsController.dispose();
_languagesController.dispose();
_feeController.dispose();
_linkedinController.dispose();
_daysController.dispose();
_slotsController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff08131F),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
title: Text(
"Become a Mentor",
style: GoogleFonts.poppins(
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
centerTitle: true,
),

body: Form(
key: _formKey,
child: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
children: [

Container(
width: double.infinity,
padding: const EdgeInsets.all(22),
decoration: BoxDecoration(
color: Colors.white.withOpacity(.05),
borderRadius: BorderRadius.circular(22),
border: Border.all(
color: Colors.white10,
),
),

child: Column(
children: [

const CircleAvatar(
radius: 45,
backgroundColor: Colors.blue,
child: Icon(
Icons.workspace_premium,
size: 45,
color: Colors.white,
),
),

const SizedBox(height: 18),

Text(
"Apply as a Mentor",
style: GoogleFonts.poppins(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
"Share your knowledge and guide learners around the world.",
textAlign: TextAlign.center,
style: GoogleFonts.poppins(
color: Colors.white60,
),
),
],
),
),

const SizedBox(height: 25),
_TextField(
controller: _nameController,
label: "Full Name",
icon: Icons.person,
),

const SizedBox(height: 16),

_TextField(
controller: _designationController,
label: "Designation",
icon: Icons.badge,
),

const SizedBox(height: 16),

_TextField(
controller: _companyController,
label: "Company",
icon: Icons.business,
),

const SizedBox(height: 16),

_TextField(
controller: _expertiseController,
label: "Expertise",
icon: Icons.psychology,
),

const SizedBox(height: 16),

_TextField(
controller: _experienceController,
label: "Experience",
icon: Icons.work_history,
),

const SizedBox(height: 16),

_TextField(
controller: _bioController,
label: "Professional Bio",
icon: Icons.description,
maxLines: 4,
),

const SizedBox(height: 16),

_TextField(
controller: _skillsController,
label: "Skills (comma separated)",
icon: Icons.code,
),

const SizedBox(height: 16),

_TextField(
controller: _languagesController,
label: "Languages (comma separated)",
icon: Icons.language,
),

const SizedBox(height: 16),

_TextField(
controller: _feeController,
label: "Session Fee",
icon: Icons.currency_rupee,
keyboardType: TextInputType.number,
),

const SizedBox(height: 16),

_TextField(
controller: _linkedinController,
label: "LinkedIn URL",
icon: Icons.link,
),

const SizedBox(height: 16),

_TextField(
controller: _daysController,
label: "Available Days",
icon: Icons.calendar_today,
),

const SizedBox(height: 16),

_TextField(
controller: _slotsController,
label: "Available Time Slots",
icon: Icons.access_time,
),

const SizedBox(height: 30),
  SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: loading
          ? null
          : () async {
        if (!_formKey.currentState!.validate()) return;

        setState(() {
          loading = true;
        });

        try {
          await MentorService().applyForMentor(
            name: _nameController.text.trim(),
            designation: _designationController.text.trim(),
            company: _companyController.text.trim(),
            expertise: _expertiseController.text.trim(),
            experience: _experienceController.text.trim(),
            bio: _bioController.text.trim(),
            skills: _skillsController.text
                .split(",")
                .map((e) => e.trim())
                .toList(),
            languages: _languagesController.text
                .split(",")
                .map((e) => e.trim())
                .toList(),
            fee: double.tryParse(_feeController.text) ?? 0,
            availableDays: _daysController.text
                .split(",")
                .map((e) => e.trim())
                .toList(),
            availableSlots: _slotsController.text
                .split(",")
                .map((e) => e.trim())
                .toList(),
            linkedin: _linkedinController.text.trim(),
          );

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Application submitted successfully!",
              ),
            ),
          );

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Application submitted. Wait for admin approval.",
              ),
            ),
          );
        } on DioException catch (e) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.response?.data["message"] ??
                    "Something went wrong",
              ),
            ),
          );
        } finally {
          if (mounted) {
            setState(() {
              loading = false;
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: loading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : Text(
        "Submit Application",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  ),

],
),
),
),
);
}
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _TextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter $label";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}