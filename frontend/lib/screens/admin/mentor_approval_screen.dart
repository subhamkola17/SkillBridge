import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/mentor_model.dart';
import '../../services/mentor_service.dart';
import 'admin_dashboard_screen.dart';
import '../profile/profile_screen.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';

class MentorApprovalScreen extends StatefulWidget {
  const MentorApprovalScreen({super.key});

  @override
  State<MentorApprovalScreen> createState() =>
      _MentorApprovalScreenState();
}

class _MentorApprovalScreenState
    extends State<MentorApprovalScreen> {
final MentorService _mentorService = MentorService();

bool loading = true;

List<Mentor> mentors = [];

@override
void initState() {
super.initState();
loadPendingMentors();
}

Future<void> loadPendingMentors() async {
try {
final data = await _mentorService.getPendingMentors();

setState(() {
mentors = data;
loading = false;
});
} on DioException catch (e) {
setState(() {
loading = false;
});

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
e.response?.data["message"] ??
"Failed to load pending mentors",
),
),
);
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff08131F),

  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text("Admin"),
          accountEmail: Text("SkillBridge Administrator"),
        ),

        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text("Dashboard"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminDashboardScreen(),
              ),
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.verified_user),
          title: const Text("Mentor Approvals"),
          onTap: () {
            Navigator.pop(context); // closes only the drawer
          },
        ),

        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Profile"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          },
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Logout"),
          onTap: () async {
            await AuthService().logout();

            if (!context.mounted) return;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
                  (route) => false,
            );
          },
        ),
      ],
    ),
  ),

  appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,



    title: Text(
      "Mentor Approvals",
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

body: loading
? const Center(
child: CircularProgressIndicator(),
)
: mentors.isEmpty
? Center(
child: Text(
"No Pending Applications",
style: GoogleFonts.poppins(
color: Colors.white70,
fontSize: 18,
),
),
)
: ListView.builder(
padding: const EdgeInsets.all(18),
itemCount: mentors.length,
itemBuilder: (context, index) {
final mentor = mentors[index];
return Card(
color: const Color(0xff13202F),
margin: const EdgeInsets.only(bottom: 18),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
child: Padding(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Text(
mentor.name,
style: GoogleFonts.poppins(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 14),

_infoRow(
Icons.badge,
"Designation",
mentor.designation,
),

_infoRow(
Icons.business,
"Company",
mentor.company,
),

_infoRow(
Icons.psychology,
"Expertise",
mentor.expertise,
),

_infoRow(
Icons.work_history,
"Experience",
mentor.experience,
),

_infoRow(
Icons.currency_rupee,
"Session Fee",
mentor.fee.toString(),
),

_infoRow(
Icons.language,
"Languages",
mentor.languages.join(", "),
),

const SizedBox(height: 16),

Text(
"Professional Bio",
style: GoogleFonts.poppins(
color: Colors.lightBlueAccent,
fontWeight: FontWeight.w600,
),
),

const SizedBox(height: 6),

Text(
mentor.bio,
style: GoogleFonts.poppins(
color: Colors.white70,
),
),

const SizedBox(height: 16),

Wrap(
spacing: 8,
runSpacing: 8,
children: mentor.skills
.map(
(skill) => Chip(
backgroundColor: Colors.blue.shade700,
label: Text(
skill,
style: const TextStyle(
color: Colors.white,
),
),
),
)
.toList(),
),

const SizedBox(height: 24),
  Row(
    children: [
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () async {
            try {
              await _mentorService.approveMentor(mentor.id);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mentor approved successfully"),
                ),
              );

              loadPendingMentors();
            } on DioException catch (e) {
              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.response?.data["message"] ??
                        "Failed to approve mentor",
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.check),
          label: const Text("Approve"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: ElevatedButton.icon(
          onPressed: () async {
            try {
              await _mentorService.rejectMentor(mentor.id);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mentor rejected"),
                ),
              );

              loadPendingMentors();
            } on DioException catch (e) {
              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.response?.data["message"] ??
                        "Failed to reject mentor",
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.close),
          label: const Text("Reject"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    ],
  ),
],
),
),
);
},
),
);
}

Widget _infoRow(
    IconData icon,
    String title,
    String value,
    ) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.lightBlueAccent,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: "$title: ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}