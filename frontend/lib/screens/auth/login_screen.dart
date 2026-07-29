import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../onboarding/role_selection_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'register_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../mentors/mentor_dashboard_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

late AnimationController _controller;

bool hidePassword = true;

final email = TextEditingController();
final password = TextEditingController();

@override
void initState() {
super.initState();

_controller = AnimationController(
vsync: this,
duration: const Duration(seconds: 15),
)..repeat();
}

@override
void dispose() {
email.dispose();
password.dispose();
_controller.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {

final size = MediaQuery.of(context).size;

return Scaffold(
body: AnimatedBuilder(
animation: _controller,
builder: (context, child) {

return Stack(

children: [

Container(

decoration: BoxDecoration(

gradient: LinearGradient(

begin: Alignment.topLeft,

end: Alignment.bottomRight,

colors: [

Color.lerp(
const Color(0xff071E3D),
const Color(0xff0F4C81),
sin(_controller.value * pi) * .5 + .5)!,

Color.lerp(
const Color(0xff1F4287),
const Color(0xff278EA5),
cos(_controller.value * pi) * .5 + .5)!,

const Color(0xff21A6FF),

],
),
),
),

Positioned(

top: -70,

left: -60,

child: _bubble(220, Colors.white10),

),

Positioned(

top: 100,

right: -80,

child: _bubble(180, Colors.white12),

),

Positioned(

bottom: -80,

left: -50,

child: _bubble(240, Colors.white10),

),

Positioned(

bottom: 160,

right: -40,

child: _bubble(120, Colors.white12),

),

SafeArea(

child: Center(

child: SingleChildScrollView(

padding: const EdgeInsets.symmetric(horizontal: 28),

child: Column(

children: [

Hero(

tag: "logo",

child: Container(

width: 125,

height: 125,

decoration: BoxDecoration(

color: Colors.white,

shape: BoxShape.circle,

boxShadow: [

BoxShadow(

color: Colors.blueAccent.withOpacity(.45),

blurRadius: 40,

spreadRadius: 4,

)

],
),

child: const Icon(

Icons.school_rounded,

color: Color(0xff1F5EFF),

size: 65,

),

),

),

const SizedBox(height: 25),

Text(

"SkillBridge",

style: GoogleFonts.poppins(

fontSize: 38,

color: Colors.white,

fontWeight: FontWeight.bold,

),

),

const SizedBox(height: 8),

Text(

"Empowering Students. Building Careers.",

textAlign: TextAlign.center,

style: GoogleFonts.poppins(

color: Colors.white70,

fontSize: 15,

),

),

const SizedBox(height: 45),

Container(

width: min(size.width, 480),

padding: const EdgeInsets.all(28),

decoration: BoxDecoration(

color: Colors.white.withOpacity(.14),

borderRadius: BorderRadius.circular(30),

border: Border.all(

color: Colors.white24,

),

),

child: Column(

children: [
TextField(
controller: email,
keyboardType: TextInputType.emailAddress,
style: GoogleFonts.poppins(
color: Colors.white,
),
decoration: InputDecoration(
filled: true,
fillColor: Colors.white.withOpacity(.10),
hintText: "Email Address",
hintStyle: GoogleFonts.poppins(
color: Colors.white60,
),
prefixIcon: const Icon(
Icons.email_outlined,
color: Colors.white,
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide(
color: Colors.white.withOpacity(.15),
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: const BorderSide(
color: Colors.white,
width: 1.5,
),
),
),
),

const SizedBox(height: 22),

TextField(
controller: password,
obscureText: hidePassword,
style: GoogleFonts.poppins(
color: Colors.white,
),
decoration: InputDecoration(
filled: true,
fillColor: Colors.white.withOpacity(.10),
hintText: "Password",
hintStyle: GoogleFonts.poppins(
color: Colors.white60,
),
prefixIcon: const Icon(
Icons.lock_outline,
color: Colors.white,
),
suffixIcon: IconButton(
icon: AnimatedSwitcher(
duration: const Duration(milliseconds: 250),
child: Icon(
hidePassword
? Icons.visibility
: Icons.visibility_off,
key: ValueKey(hidePassword),
color: Colors.white,
),
),
onPressed: () {
setState(() {
hidePassword = !hidePassword;
});
},
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide.none,
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: BorderSide(
color: Colors.white.withOpacity(.15),
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(18),
borderSide: const BorderSide(
color: Colors.white,
width: 1.5,
),
),
),
),

const SizedBox(height: 12),

Align(
alignment: Alignment.centerRight,
child: TextButton(
onPressed: () {},
child: Text(
"Forgot Password?",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.w500,
),
),
),
),

const SizedBox(height: 18),
SizedBox(
width: double.infinity,
height: 60,
child: DecoratedBox(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(18),
gradient: const LinearGradient(
colors: [
Color(0xff00C6FF),
Color(0xff0072FF),
],
),
boxShadow: [
BoxShadow(
color: Colors.blueAccent.withOpacity(.45),
blurRadius: 25,
offset: const Offset(0, 10),
),
],
),
child: ElevatedButton(
  onPressed: () async {
    final provider = context.read<AuthProvider>();

    final success = await provider.login(
      email.text.trim(),
      password.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      final user = provider.user!;

      if (user.role == "Admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const AdminDashboardScreen(),
          ),
        );
      } else if (user.role == "Mentor" &&
          user.mentorStatus == "Approved") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MentorDashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password"),
        ),
      );
    }
  },
style: ElevatedButton.styleFrom(
backgroundColor: Colors.transparent,
shadowColor: Colors.transparent,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
  child: Consumer<AuthProvider>(
    builder: (_, auth, __) {
      if (auth.loading) {
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      }

      return Text(
        "LOGIN",
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: Colors.white,
        ),
      );
    },
  ),
),
),
),

const SizedBox(height: 25),

Row(
children: [
Expanded(
child: Divider(
color: Colors.white.withOpacity(.3),
),
),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 12),
child: Text(
"OR",
style: GoogleFonts.poppins(
color: Colors.white70,
),
),
),
Expanded(
child: Divider(
color: Colors.white.withOpacity(.3),
),
),
],
),

const SizedBox(height: 22),

SizedBox(
width: double.infinity,
height: 56,
child: OutlinedButton.icon(
onPressed: () {},
icon: const Icon(
Icons.g_mobiledata,
size: 34,
color: Colors.white,
),
label: Text(
"Continue with Google",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.w600,
),
),
style: OutlinedButton.styleFrom(
side: BorderSide(
color: Colors.white.withOpacity(.30),
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
),
),

const SizedBox(height: 16),

SizedBox(
width: double.infinity,
height: 56,
child: OutlinedButton.icon(
onPressed: () {},
icon: const Icon(
Icons.code,
color: Colors.white,
),
label: Text(
"Continue with GitHub",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.w600,
),
),
style: OutlinedButton.styleFrom(
side: BorderSide(
color: Colors.white.withOpacity(.30),
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
),
),

const SizedBox(height: 28),

Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
"Don't have an account? ",
style: GoogleFonts.poppins(
color: Colors.white70,
),
),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
      ),
    );
  },
child: Text(
"Register",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
],
),

const SizedBox(height: 25),

Text(
"© 2026 SkillBridge",
style: GoogleFonts.poppins(
color: Colors.white54,
fontSize: 13,
),
),
  ],
  ),
  ),

  const SizedBox(height: 40),
  ],
  ),
  ),
  ),
),
  ],
  );
},
),
);
}

Widget _bubble(double size, Color color) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(.35),
          blurRadius: 40,
          spreadRadius: 5,
        ),
      ],
    ),
  );
}
}