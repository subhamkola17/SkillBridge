


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
final _formKey = GlobalKey<FormState>();

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();
final _locationController = TextEditingController();
final _experienceController = TextEditingController();
final _bioController = TextEditingController();
final _skillsController = TextEditingController();

String role = "";

bool loading = true;
bool saving = false;



@override
void initState() {
super.initState();
loadProfile();
}

Future<void> loadProfile() async {
try {
UserModel user = await AuthService().getProfile();

_nameController.text = user.name;
_emailController.text = user.email;
_phoneController.text = user.phone ?? "";
_locationController.text = user.location ?? "";
_experienceController.text = user.experience ?? "";
_bioController.text = user.bio ?? "";
_skillsController.text = user.skills.join(", ");

role = user.role;

if (mounted) {
setState(() {
loading = false;
});
}
} catch (e) {
debugPrint(e.toString());

if (mounted) {
setState(() {
loading = false;
});
}
}
}


@override
void dispose() {
_nameController.dispose();
_emailController.dispose();
_phoneController.dispose();
_locationController.dispose();
_experienceController.dispose();
_bioController.dispose();
_skillsController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
if (loading) {
return const Scaffold(
backgroundColor: Color(0xff08131F),
body: Center(
child: CircularProgressIndicator(),
),
);
}

return Scaffold(
backgroundColor: const Color(0xff08131F),

appBar: AppBar(
backgroundColor: Colors.transparent,
elevation: 0,
centerTitle: true,
title: Text(
"Edit Profile",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),

body: SingleChildScrollView(
padding: const EdgeInsets.all(20),

child: Form(
key: _formKey,

child: Column(
children: [

const SizedBox(height: 20),

  CircleAvatar(
    radius: 55,
    backgroundColor: Colors.blue,
    child: Text(
      _nameController.text.isNotEmpty
          ? _nameController.text[0].toUpperCase()
          : "S",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

const SizedBox(height: 30),
const SizedBox(height: 30),

TextFormField(
controller: _nameController,
onChanged: (_) => setState(() {}),
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Full Name",
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.person, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Enter your name";
}
return null;
},
),

const SizedBox(height: 20),

TextFormField(
controller: _emailController,
keyboardType: TextInputType.emailAddress,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Email",
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.email, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 20),

TextFormField(
initialValue: role,
enabled: false,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Role",
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.badge, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 20),

TextFormField(
controller: _phoneController,
keyboardType: TextInputType.phone,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Phone Number",
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.phone, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 20),

TextFormField(
controller: _locationController,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Location",
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 20),

TextFormField(
controller: _experienceController,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Experience",
hintText: "e.g. Flutter Developer, 2 Years",
hintStyle: const TextStyle(color: Colors.white38),
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.work, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 25),



TextFormField(
controller: _bioController,
maxLines: 4,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Bio",
hintText: "Tell us something about yourself...",
hintStyle: const TextStyle(color: Colors.white38),
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.description, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 20),

TextFormField(
controller: _skillsController,
maxLines: 2,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
labelText: "Skills",
hintText: "Flutter, Dart, Firebase",
hintStyle: const TextStyle(color: Colors.white38),
labelStyle: const TextStyle(color: Colors.white70),
prefixIcon: const Icon(Icons.psychology, color: Colors.blue),
filled: true,
fillColor: Colors.white.withOpacity(.06),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 35),
  SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: saving
          ? null
          : () async {
        if (!_formKey.currentState!.validate()) return;

        setState(() {
          saving = true;
        });

        try {
          await AuthService().updateProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            location: _locationController.text.trim(),
            experience: _experienceController.text.trim(),
            bio: _bioController.text.trim(),
            skills: _skillsController.text.trim(),
          );

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile Updated Successfully"),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pop(context, true);
        } catch (e) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          if (mounted) {
            setState(() {
              saving = false;
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: saving
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Text(
        "Save Changes",
        style: GoogleFonts.poppins(
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