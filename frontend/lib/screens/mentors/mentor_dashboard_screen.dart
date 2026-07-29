import 'package:flutter/material.dart';
import '../mentor_booking/mentor_booking_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';
import 'mentor_dashboard_screen.dart';
import '../mentor_booking/mentor_booking_screen.dart';

class MentorDashboardScreen extends StatelessWidget {
  const MentorDashboardScreen({super.key});

  Widget buildCard(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            Container(
              height: 210,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2563EB),
                    Color(0xff1D4ED8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school,
                      size: 42,
                      color: Color(0xff2563EB),
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "SkillBridge Mentor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Mentor Dashboard",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text("Booking Requests"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MentorBookingsScreen(),
                  ),
                );
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
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
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
        title: const Text("Mentor Dashboard"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [

          buildCard(
            context,
            Icons.assignment,
            "Booking Requests",
            Colors.blue,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MentorBookingsScreen(),
                ),
              );
            },
          ),

          buildCard(
            context,
            Icons.video_call,
            "Upcoming Sessions",
            Colors.green,
                () {},
          ),

          buildCard(
            context,
            Icons.check_circle,
            "Completed Sessions",
            Colors.orange,
                () {},
          ),

          buildCard(
            context,
            Icons.person,
            "My Profile",
            Colors.purple,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}