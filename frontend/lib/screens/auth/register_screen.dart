import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
final _formKey = GlobalKey<FormState>();

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController =
TextEditingController();

String selectedRole = "Student";

bool hidePassword = true;
bool hideConfirmPassword = true;

late AnimationController _animationController;
late Animation<double> _fadeAnimation;

@override
void initState() {
super.initState();

_animationController = AnimationController(
vsync: this,
duration: const Duration(milliseconds: 800),
);

_fadeAnimation = CurvedAnimation(
parent: _animationController,
curve: Curves.easeInOut,
);

_animationController.forward();
}

@override
void dispose() {
_animationController.dispose();
nameController.dispose();
emailController.dispose();
passwordController.dispose();
confirmPasswordController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF08131F),
body: SafeArea(
child: FadeTransition(
opacity: _fadeAnimation,
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(
horizontal: 24,
vertical: 20,
),
child: Container(
width: 470,
padding: const EdgeInsets.all(28),
decoration: BoxDecoration(
color: Colors.white.withOpacity(.08),
borderRadius: BorderRadius.circular(28),
border: Border.all(
color: Colors.white24,
),
),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Icon(
Icons.person_add_alt_1_rounded,
size: 70,
color: Colors.blue.shade300,
),

const SizedBox(height: 18),

Text(
"Create Account",
textAlign: TextAlign.center,
style: GoogleFonts.poppins(
color: Colors.white,
fontSize: 32,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(
"Join SkillBridge and start your journey.",
textAlign: TextAlign.center,
style: GoogleFonts.poppins(
color: Colors.white70,
fontSize: 15,
),
),

const SizedBox(height: 35),

TextFormField(
controller: nameController,
style: const TextStyle(
color: Colors.white,
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Please enter your full name";
}
return null;
},
decoration: InputDecoration(
hintText: "Full Name",
hintStyle: const TextStyle(
color: Colors.white54,
),
prefixIcon: const Icon(
Icons.person_outline,
color: Colors.white70,
),
filled: true,
fillColor: Colors.white10,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 18),

TextFormField(
controller: emailController,
keyboardType: TextInputType.emailAddress,
style: const TextStyle(
color: Colors.white,
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Please enter email";
}

if (!value.contains("@")) {
return "Enter a valid email";
}

return null;
},
decoration: InputDecoration(
hintText: "Email Address",
hintStyle: const TextStyle(
color: Colors.white54,
),
prefixIcon: const Icon(
Icons.email_outlined,
color: Colors.white70,
),
filled: true,
fillColor: Colors.white10,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 18),
TextFormField(
controller: passwordController,
obscureText: hidePassword,
style: const TextStyle(
color: Colors.white,
),
validator: (value) {
if (value == null || value.isEmpty) {
return "Please enter password";
}

if (value.length < 6) {
return "Password must be at least 6 characters";
}

return null;
},
decoration: InputDecoration(
hintText: "Password",
hintStyle: const TextStyle(
color: Colors.white54,
),
prefixIcon: const Icon(
Icons.lock_outline,
color: Colors.white70,
),
suffixIcon: IconButton(
onPressed: () {
setState(() {
hidePassword = !hidePassword;
});
},
icon: Icon(
hidePassword
? Icons.visibility_off
: Icons.visibility,
color: Colors.white70,
),
),
filled: true,
fillColor: Colors.white10,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 18),

TextFormField(
controller: confirmPasswordController,
obscureText: hideConfirmPassword,
style: const TextStyle(
color: Colors.white,
),
validator: (value) {
if (value == null || value.isEmpty) {
return "Confirm your password";
}

if (value != passwordController.text) {
return "Passwords do not match";
}

return null;
},
decoration: InputDecoration(
hintText: "Confirm Password",
hintStyle: const TextStyle(
color: Colors.white54,
),
prefixIcon: const Icon(
Icons.lock_reset,
color: Colors.white70,
),
suffixIcon: IconButton(
onPressed: () {
setState(() {
hideConfirmPassword =
!hideConfirmPassword;
});
},
icon: Icon(
hideConfirmPassword
? Icons.visibility_off
: Icons.visibility,
color: Colors.white70,
),
),
filled: true,
fillColor: Colors.white10,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
),

const SizedBox(height: 18),

DropdownButtonFormField<String>(
value: selectedRole,
dropdownColor: const Color(0xFF1E293B),
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
prefixIcon: const Icon(
Icons.badge_outlined,
color: Colors.white70,
),
filled: true,
fillColor: Colors.white10,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
),
items: const [
DropdownMenuItem(
value: "Student",
child: Text("Student"),
),
DropdownMenuItem(
value: "Job Seeker",
child: Text("Job Seeker"),
),
DropdownMenuItem(
value: "Mentor",
child: Text("Mentor"),
),
],
onChanged: (value) {
setState(() {
selectedRole = value!;
});
},
),

const SizedBox(height: 30),

Consumer<AuthProvider>(
builder: (context, auth, child) {
return SizedBox(
height: 55,
child: ElevatedButton(
  onPressed: auth.loading
? null
: () async {
if (!_formKey.currentState!
.validate()) {
return;
}

bool success = await auth.register(
  nameController.text.trim(),
  emailController.text.trim(),
  passwordController.text.trim(),
  selectedRole,
);
if (success) {
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Registration Successful!",
        ),
      ),
    );

    Navigator.pop(context);
  }
} else {
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Registration Failed",
        ),
      ),
    );
  }
}
},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(18),
    ),
  ),
  child: auth.loading
      ? const CircularProgressIndicator(
    color: Colors.white,
  )
      : Text(
    "Create Account",
    style: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
),
);
},
),

  const SizedBox(height: 25),

  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Already have an account?",
        style: GoogleFonts.poppins(
          color: Colors.white70,
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Login",
          style: GoogleFonts.poppins(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
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
),
),
),
);
}
}