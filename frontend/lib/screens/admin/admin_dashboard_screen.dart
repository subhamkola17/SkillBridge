import 'package:flutter/material.dart';

import '../../models/dashboard_stats.dart';
import '../../services/dashboard_service.dart';
import '../../widgets/dashboard/stat_card.dart';
import 'mentor_approval_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../auth/login_screen.dart';
import '../../services/auth_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {
  final DashboardService _dashboardService =
  DashboardService();

  DashboardStats? stats;

  bool isLoading = true;

  String? error;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await _dashboardService.getDashboardStats();

      if (!mounted) return;

      setState(() {
        stats = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Widget _quickAction({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("SkillBridge Administrator"),
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
              leading: const Icon(Icons.verified_user),
              title: const Text("Mentor Approvals"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MentorApprovalScreen(),
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
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Admin Dashboard",
        ),
      ),

      body: RefreshIndicator(
        onRefresh: loadDashboard,
        child: Builder(
          builder: (_) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (error != null) {
              return Center(
                child: Text(error!),
              );
            }

            return RefreshIndicator(
              onRefresh: loadDashboard,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Welcome Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff2563EB),
                            Color(0xff1D4ED8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Manage SkillBridge from one place.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Platform Overview",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 2.1,
                      children: [

                        StatCard(
                          title: "Users",
                          value: "${stats!.totalUsers}",
                          icon: Icons.people,
                          color: Colors.blue,
                        ),

                        StatCard(
                          title: "Mentors",
                          value: "${stats!.totalMentors}",
                          icon: Icons.school,
                          color: Colors.green,
                        ),

                        StatCard(
                          title: "Pending",
                          value: "${stats!.pendingMentors}",
                          icon: Icons.pending_actions,
                          color: Colors.orange,
                        ),

                        StatCard(
                          title: "Jobs",
                          value: "${stats!.totalJobs}",
                          icon: Icons.work,
                          color: Colors.deepPurple,
                        ),

                        StatCard(
                          title: "Internships",
                          value: "${stats!.totalInternships}",
                          icon: Icons.business_center,
                          color: Colors.red,
                        ),

                        StatCard(
                          title: "Hackathons",
                          value: "${stats!.totalHackathons}",
                          icon: Icons.emoji_events,
                          color: Colors.amber,
                        ),

                        StatCard(
                          title: "Courses",
                          value: "${stats!.totalCourses}",
                          icon: Icons.menu_book,
                          color: Colors.teal,
                        ),

                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [

                        _quickAction(
                          icon: Icons.work_outline,
                          title: "Jobs",
                          color: Colors.deepPurple,
                          onTap: () {},
                        ),

                        _quickAction(
                          icon: Icons.school_outlined,
                          title: "Mentors",
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MentorApprovalScreen(),
                              ),
                            );
                          },
                        ),

                        _quickAction(
                          icon: Icons.menu_book_outlined,
                          title: "Courses",
                          color: Colors.teal,
                          onTap: () {},
                        ),

                        _quickAction(
                          icon: Icons.emoji_events_outlined,
                          title: "Hackathons",
                          color: Colors.orange,
                          onTap: () {},
                        ),

                        _quickAction(
                          icon: Icons.business_center_outlined,
                          title: "Internships",
                          color: Colors.red,
                          onTap: () {},
                        ),

                        _quickAction(
                          icon: Icons.people_outline,
                          title: "Users",
                          color: Colors.blue,
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Admin Tools",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.verified_user, color: Colors.green),
                            title: const Text("Mentor Approvals"),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MentorApprovalScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          const ListTile(
                            leading: Icon(Icons.analytics, color: Colors.blue),
                            title: Text("Platform Analytics"),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                          const Divider(height: 1),
                          const ListTile(
                            leading: Icon(Icons.settings, color: Colors.grey),
                            title: Text("Settings"),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}