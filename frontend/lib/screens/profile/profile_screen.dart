import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import 'edit_profile_screen.dart';
import '../mentors/become_mentor_screen.dart';
import '../admin/mentor_approval_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
UserModel? user;
bool loading = true;

@override
void initState() {
super.initState();
loadProfile();
}

Future<void> loadProfile() async {
  try {
    final profile = await AuthService().getProfile();

    setState(() {
      user = profile;
      loading = false;
    });
  } catch (e) {
    debugPrint(e.toString());

    setState(() {
      loading = false;
    });
  }
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
"My Profile",
style: GoogleFonts.poppins(
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),

body: SingleChildScrollView(
padding: const EdgeInsets.all(20),

child: Column(
children: [

Container(
width: double.infinity,
padding: const EdgeInsets.all(24),

decoration: BoxDecoration(
color: Colors.white.withOpacity(.08),
borderRadius: BorderRadius.circular(25),
border: Border.all(
color: Colors.white24,
),
),

child: Column(
children: [

  CircleAvatar(
    radius: 55,
    backgroundColor: Colors.blue,
    backgroundImage: (user?.profileImage != null &&
        user!.profileImage!.trim().isNotEmpty)
        ? NetworkImage(user!.profileImage!)
        : null,
    child: (user?.profileImage == null ||
        user!.profileImage!.trim().isEmpty)
        ? Text(
      user != null && user!.name.isNotEmpty
          ? user!.name[0].toUpperCase()
          : "U",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    )
        : null,
  ),

const SizedBox(height: 20),

Text(
user?.name ?? "",
style: GoogleFonts.poppins(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
user?.email ?? "",
style: GoogleFonts.poppins(
color: Colors.white70,
fontSize: 15,
),
),

const SizedBox(height: 15),

Container(
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 8,
),

decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(30),
),

child: Text(
user?.role ?? "",
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.w600,
),
),
),

const SizedBox(height: 30),
  _buildMenuTile(
    icon: Icons.edit,
    title: "Edit Profile",
    subtitle: "Update your personal information",
    onTap: () async {
      final updated = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        ),
      );

      if (updated == true) {
        loadProfile();
      }
    },
  ),



const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.work_outline,
title: "Saved Jobs",
subtitle: "View your bookmarked jobs",
onTap: () {},
),

const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.school_outlined,
title: "Applied Internships",
subtitle: "Track your internship applications",
onTap: () {},
),

const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.emoji_events_outlined,
title: "Hackathons",
subtitle: "Your registered hackathons",
onTap: () {},
),

const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.psychology_alt_outlined,
title: "Mentorship",
subtitle: "Your mentorship sessions",
onTap: () {},
),

  const SizedBox(height: 15),

  _buildMenuTile(
    icon: Icons.workspace_premium,
    title: "Become a Mentor",
    subtitle: "Share your knowledge with the community",
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BecomeMentorScreen(),
        ),
      );
    },
  ),

  const SizedBox(height: 15),

  _buildMenuTile(
    icon: Icons.admin_panel_settings,
    title: "Mentor Approvals",
    subtitle: "Approve or reject mentor applications",
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MentorApprovalScreen(),
        ),
      );
    },
  ),

  const SizedBox(height: 15),

  _buildMenuTile(
    icon: Icons.dashboard_customize_rounded,
    title: "Admin Dashboard",
    subtitle: "Manage SkillBridge platform",
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
        ),
      );
    },
  ),

const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.settings_outlined,
title: "Settings",
subtitle: "Manage your preferences",
onTap: () {},
),

const SizedBox(height: 15),

_buildMenuTile(
icon: Icons.info_outline,
title: "About SkillBridge",
subtitle: "Privacy Policy, Terms & Version",
onTap: () {},
),

const SizedBox(height: 35),

SizedBox(
width: double.infinity,
height: 55,
child: ElevatedButton.icon(
  onPressed: () async {
    await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  },
icon: const Icon(Icons.logout),
label: Text(
"Logout",
style: GoogleFonts.poppins(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.red,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
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

Widget _buildMenuTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.withOpacity(0.15),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white54,
            size: 18,
          ),
        ],
      ),
    ),
  );
}
}