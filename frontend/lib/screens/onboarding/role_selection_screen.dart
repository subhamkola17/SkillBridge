import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/home_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {

int selectedIndex = -1;
bool loading = false;

final List<Map<String, dynamic>> roles = [
{
"title": "Student",
"subtitle":
"Learn new skills, build projects and get internship opportunities.",
"icon": Icons.school_rounded,
"color": const Color(0xff4285F4),
},
{
"title": "Job Seeker",
"subtitle":
"Create a professional resume, prepare for interviews and discover jobs.",
"icon": Icons.work_rounded,
"color": const Color(0xff00BCD4),
},
{
"title": "Mentor",
"subtitle":
"Guide students, share your experience and inspire future talent.",
"icon": Icons.psychology_alt_rounded,
"color": const Color(0xff7B61FF),
},
];

late AnimationController controller;

@override
void initState() {
super.initState();

controller = AnimationController(
vsync: this,
duration: const Duration(seconds: 8),
)..repeat(reverse: true);
}

@override
void dispose() {
controller.dispose();
super.dispose();
}

Future<void> continuePressed() async {
if (selectedIndex == -1) return;

setState(() {
loading = true;
});

await Future.delayed(const Duration(seconds: 1));

if (!mounted) return;

Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => const HomeScreen(),
),
);
}

@override
Widget build(BuildContext context) {

return Scaffold(

body: AnimatedBuilder(

animation: controller,

builder: (context, child) {

return Container(

decoration: BoxDecoration(

gradient: LinearGradient(

begin: Alignment.topLeft,

end: Alignment.bottomRight,

colors: [

Color.lerp(
const Color(0xff071E3D),
const Color(0xff1565C0),
controller.value,
)!,

Color.lerp(
const Color(0xff1565C0),
const Color(0xff26C6DA),
controller.value,
)!,

],
),
),

child: SafeArea(

child: Stack(

children: [

Positioned(
top: -70,
left: -60,
child: circle(180),
),

Positioned(
bottom: -70,
right: -60,
child: circle(220),
),

Padding(

padding: const EdgeInsets.symmetric(
horizontal: 24,
),

child: Column(

children: [

const SizedBox(height: 30),

Hero(

tag: "logo",

child: CircleAvatar(

radius: 45,

backgroundColor: Colors.white,

child: Icon(
Icons.school_rounded,
color: Colors.blue.shade700,
size: 45,
),
),
),

const SizedBox(height: 20),

Text(

"Choose Your Path",

style: GoogleFonts.poppins(

color: Colors.white,

fontSize: 30,

fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(

"Let's personalize your SkillBridge experience.",

textAlign: TextAlign.center,

style: GoogleFonts.poppins(

color: Colors.white70,

fontSize: 15,
),
),

const SizedBox(height: 30),

Expanded(

child: ListView.builder(

itemCount: roles.length,

itemBuilder: (context, index) {

bool selected =
selectedIndex == index;

return AnimatedScale(

duration: const Duration(
milliseconds: 250,
),

scale: selected ? 1.03 : 1,

child: GestureDetector(

onTap: () {

setState(() {

selectedIndex = index;

});

},

child: AnimatedContainer(

duration: const Duration(
milliseconds: 250,
),

margin: const EdgeInsets.only(
bottom: 20,
),

padding:
const EdgeInsets.all(20),

decoration: BoxDecoration(

color: Colors.white
.withOpacity(.12),

borderRadius:
BorderRadius.circular(24),

border: Border.all(

color: selected
? Colors.white
: Colors.white24,

width: selected ? 2 : 1,
),

boxShadow: selected
? [

BoxShadow(

color: Colors
.cyanAccent
.withOpacity(.4),

blurRadius: 25,

)

]
: [],
),

child: Row(

children: [
CircleAvatar(
radius: 32,
backgroundColor: Colors.white,
child: Icon(
roles[index]["icon"],
color: roles[index]["color"],
size: 32,
),
),

const SizedBox(width: 18),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
roles[index]["title"],
style: GoogleFonts.poppins(
color: Colors.white,
fontSize: 21,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 6),

Text(
roles[index]["subtitle"],
style: GoogleFonts.poppins(
color: Colors.white70,
height: 1.4,
fontSize: 13,
),
),
],
),
),

AnimatedSwitcher(
duration: const Duration(milliseconds: 300),
child: selected
? Container(
key: const ValueKey(true),
padding: const EdgeInsets.all(4),
decoration: const BoxDecoration(
color: Colors.white,
shape: BoxShape.circle,
),
child: Icon(
Icons.check,
color: roles[index]["color"],
),
)
: const SizedBox(
key: ValueKey(false),
width: 28,
),
),
],
),
),
),
);
},
),
),

const SizedBox(height: 10),

SizedBox(
width: double.infinity,
height: 58,
child: ElevatedButton(
  onPressed: (selectedIndex == -1 || loading)
      ? null
      : continuePressed,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: Colors.blue,
elevation: 12,
shadowColor: Colors.cyanAccent,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
child: loading
? const SizedBox(
width: 24,
height: 24,
child: CircularProgressIndicator(
strokeWidth: 3,
),
)
: Text(
"Continue →",
style: GoogleFonts.poppins(
fontWeight: FontWeight.bold,
fontSize: 18,
),
),
),
),

const SizedBox(height: 18),

Text(
"You can always change this later from Settings.",
textAlign: TextAlign.center,
style: GoogleFonts.poppins(
color: Colors.white70,
fontSize: 13,
),
),

const SizedBox(height: 20),
],
),
),

  ],
),
  ),
  );
},
),
);
}

Widget circle(double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.08),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.10),
          blurRadius: 40,
          spreadRadius: 10,
        ),
      ],
    ),
  );
}
}