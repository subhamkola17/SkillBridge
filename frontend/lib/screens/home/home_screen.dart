import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../internships/internship_screen.dart';
import '../jobs/job_screen.dart';
import '../courses/course_screen.dart';
import '../hackathons/hackathon_screen.dart';
import '../mentors/mentor_screen.dart';
import '../ai/ai_assistant_screen.dart';
import '../resume/resume_analyzer_screen.dart';
import '../career_roadmap/career_selection_screen.dart';
import '../profile/profile_screen.dart';
import '../bookings/my_bookings_screen.dart';
import '../mentors/mentor_dashboard_screen.dart';



/// Role definition for dynamic content transformation
enum UserRole {
  student,
  jobSeeker,
  mentor,
}

void main() {
  runApp(const SkillBridgeApp());
}

class SkillBridgeApp extends StatelessWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBridge',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1120),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF818CF8),
          tertiary: Color(0xFFC084FC),
          surface: Color(0xFF0F172A),
          onSurface: Colors.white,
          outline: Color(0xFF334155),
        ),
        fontFamily: 'Roboto',
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF1E293B),
          contentTextStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  UserRole _selectedRole = UserRole.student;
  int _bottomNavIndex = 0;
  late AnimationController _bgAnimationController;

  @override
  void initState() {
    super.initState();
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgAnimationController.dispose();
    super.dispose();
  }

  void _onRoleChanged(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width >= 650;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Animated Dynamic Gradient Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgAnimationController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(
                        math.cos(_bgAnimationController.value * math.pi * 2),
                        math.sin(_bgAnimationController.value * math.pi * 2),
                      ),
                      end: Alignment(
                        -math.cos(_bgAnimationController.value * math.pi * 2),
                        -math.sin(_bgAnimationController.value * math.pi * 2),
                      ),
                      colors: const [
                        Color(0xFF070B14),
                        Color(0xFF0F172A),
                        Color(0xFF1E1B4B),
                        Color(0xFF09233A),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Glow Orbs for Glassmorphic Backing
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF38BDF8).withOpacity(0.18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF38BDF8).withOpacity(0.3),
                    blurRadius: 120,
                    spreadRadius: 60,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF818CF8).withOpacity(0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF818CF8).withOpacity(0.25),
                    blurRadius: 140,
                    spreadRadius: 70,
                  )
                ],
              ),
            ),
          ),

          // Main Scrollable Dashboard Content
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 32.0 : 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(
                          selectedRole: _selectedRole,
                          onRoleChanged: _onRoleChanged,
                        ),
                        const SizedBox(height: 20),
                        const SearchBarWidget(),
                        const SizedBox(height: 24),
                        const AIHeroCard(),
                        const SizedBox(height: 28),
                        _SectionHeader(
                          title: 'Quick Actions',
                          subtitle: _getQuickActionSubtitle(_selectedRole),
                        ),
                        const SizedBox(height: 14),
                        QuickActionGrid(role: _selectedRole, isTablet: isTablet),
                        const SizedBox(height: 28),
                        ProgressCard(role: _selectedRole),
                        const SizedBox(height: 28),
                        _SectionHeader(
                          title: _getRecommendedTitle(_selectedRole),
                          actionText: 'View All',
                          onActionTap: () {},
                        ),
                        const SizedBox(height: 14),
                        RecommendedSection(role: _selectedRole),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Upcoming Hackathons',
                          subtitle: 'Compete, build & showcase skills',
                        ),
                        const SizedBox(height: 14),
                        const HackathonSection(),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Top Mentors',
                          subtitle: '1-on-1 advice from industry leaders',
                        ),
                        const SizedBox(height: 14),
                        const TopMentorsSection(),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Career News & Insights',
                          subtitle: 'Stay ahead in tech & industry trends',
                        ),
                        const SizedBox(height: 14),
                        const NewsSection(),
                        const SizedBox(height: 120), // Bottom padding for float navigation
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AIAssistantScreen(),
              ),
            );
            return;
          }

          setState(() {
            _bottomNavIndex = index;
          });

          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  String _getQuickActionSubtitle(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'Tailored tools for learning & internships';
      case UserRole.jobSeeker:
        return 'Accelerate your hiring journey';
      case UserRole.mentor:
        return 'Manage sessions and guide talent';
    }
  }

  String _getRecommendedTitle(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'Recommended Internships';
      case UserRole.jobSeeker:
        return 'Recommended Jobs';
      case UserRole.mentor:
        return 'Mentorship Requests';
    }
  }
}

// ==========================================
// SECTION HEADER WIDGET
// ==========================================
class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionTap;

  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 3),
              Text(
                subtitle!,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: const TextStyle(
                color: Color(0xFF38BDF8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

// ==========================================
// HOME HEADER WIDGET
// ==========================================
class HomeHeader extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole> onRoleChanged;

  const HomeHeader({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'profile_avatar',
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF38BDF8), Color(0xFF818CF8)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF38BDF8).withOpacity(0.35),
                          blurRadius: 12,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=250',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Good Evening',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 600),
                          builder: (context, val, child) {
                            return Transform.rotate(
                              angle: math.sin(val * math.pi * 2) * 0.2,
                              child: const Text('👋', style: TextStyle(fontSize: 14)),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Subham Sharma',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Notification Icon with Pulse Badge
            Stack(
              children: [
                GlassContainer(
                  borderRadius: 16,
                  padding: const EdgeInsets.all(11),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF38BDF8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF38BDF8).withOpacity(0.8),
                          blurRadius: 6,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Role Selection Pill Bar
        GlassContainer(
          borderRadius: 20,
          padding: const EdgeInsets.all(4),
          child: Row(
            children: UserRole.values.map((role) {
              final isSelected = selectedRole == role;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onRoleChanged(role),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF38BDF8).withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF38BDF8).withOpacity(0.5)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getRoleLabel(role),
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'Student';
      case UserRole.jobSeeker:
        return 'Job Seeker';
      case UserRole.mentor:
        return 'Mentor';
    }
  }
}

// ==========================================
// SEARCH BAR WIDGET
// ==========================================
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: const [
          Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search internships, jobs, mentors...',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.tune_rounded, color: Color(0xFF38BDF8), size: 20),
        ],
      ),
    );
  }
}

// ==========================================
// AI HERO CARD WIDGET
// ==========================================
class AIHeroCard extends StatefulWidget {
  const AIHeroCard({super.key});

  @override
  State<AIHeroCard> createState() => _AIHeroCardState();
}

class _AIHeroCardState extends State<AIHeroCard> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF0F2744),
            Color(0xFF111827),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF38BDF8).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF38BDF8).withOpacity(0.12),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                Icons.auto_awesome,
                size: 160,
                color: const Color(0xFF38BDF8).withOpacity(0.06),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF38BDF8).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF38BDF8).withOpacity(0.4),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.bolt_rounded, color: Color(0xFF38BDF8), size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'POWERED BY AI',
                                    style: TextStyle(
                                      color: Color(0xFF38BDF8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'SkillBridge AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Ask career questions instantly. Get resume feedback, roadmaps & match alerts.',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Glowing Animated Button
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF38BDF8).withOpacity(
                                      0.3 + (_pulseController.value * 0.3),
                                    ),
                                    blurRadius: 12 + (_pulseController.value * 6),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AIAssistantScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.auto_awesome, size: 18, color: Color(0xFF0F172A)),
                                label: const Text(
                                  'Ask AI Career Assistant',
                                  style: TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF38BDF8),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
}

// ==========================================
// QUICK ACTIONS GRID
// ==========================================
class QuickActionGrid extends StatelessWidget {
  final UserRole role;
  final bool isTablet;

  const QuickActionGrid({
    super.key,
    required this.role,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final actions = _getActions(role);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isTablet ? 1.8 : 1.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final item = actions[index];
        return AnimatedQuickActionCard(
          title: item['title'] as String,
          icon: item['icon'] as IconData,
          color: item['color'] as Color,
          index: index,
        );
      },
    );
  }

  List<Map<String, dynamic>> _getActions(UserRole role) {
    switch (role) {
      case UserRole.student:
        return [
          {'title': 'Internships', 'icon': Icons.work_outline_rounded, 'color': const Color(0xFF38BDF8)},
          {'title': 'Courses', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFF818CF8)},
          {'title': 'Hackathons', 'icon': Icons.emoji_events_outlined, 'color': const Color(0xFFF43F5E)},
          {
            'title': 'Resume Analyzer',
            'icon': Icons.description_outlined,
            'color': const Color(0xFF10B981),
          },
          {'title': 'Career Roadmap', 'icon': Icons.alt_route_rounded, 'color': const Color(0xFF818CF8)},
          {'title': 'Mentors', 'icon': Icons.people_outline_rounded, 'color': const Color(0xFFC084FC)},
          {
            'title': 'My Bookings',
            'icon': Icons.calendar_month_outlined,
            'color': const Color(0xFF4CAF50),
          },
        ];
      case UserRole.jobSeeker:
        return [
          {'title': 'Jobs', 'icon': Icons.business_center_outlined, 'color': const Color(0xFF38BDF8)},
          {'title': 'Resume Score', 'icon': Icons.document_scanner_outlined, 'color': const Color(0xFF10B981)},
          {'title': 'Interview Prep', 'icon': Icons.record_voice_over_outlined, 'color': const Color(0xFFF59E0B)},
          {'title': 'Career Roadmap', 'icon': Icons.alt_route_rounded, 'color': const Color(0xFF818CF8)},
          {'title': 'Networking', 'icon': Icons.hub_outlined, 'color': const Color(0xFFC084FC)},
          {'title': 'Companies', 'icon': Icons.domain_rounded, 'color': const Color(0xFFEC4899)},

        ];
      case UserRole.mentor:
        return [
          {'title': 'Students', 'icon': Icons.school_outlined, 'color': const Color(0xFF38BDF8)},
          {'title': 'Sessions', 'icon': Icons.calendar_today_rounded, 'color': const Color(0xFF10B981)},
          {'title': 'Resources', 'icon': Icons.folder_shared_outlined, 'color': const Color(0xFF818CF8)},
          {'title': 'Community', 'icon': Icons.groups_outlined, 'color': const Color(0xFFF59E0B)},
          {'title': 'Messages', 'icon': Icons.chat_bubble_outline_rounded, 'color': const Color(0xFFC084FC)},
          {'title': 'Analytics', 'icon': Icons.bar_chart_rounded, 'color': const Color(0xFFF43F5E)},
          {
            'title': 'Dashboard',
            'icon': Icons.dashboard_rounded,
            'color': const Color(0xFF2563EB),
          },
        ];
    }
  }
}

class AnimatedQuickActionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int index;

  const AnimatedQuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.index,
  });

  @override
  State<AnimatedQuickActionCard> createState() => _AnimatedQuickActionCardState();
}

class _AnimatedQuickActionCardState extends State<AnimatedQuickActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.title == "Internships") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InternshipScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Jobs") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JobScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Courses") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CourseScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Hackathons") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HackathonScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Mentors") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MentorScreen(),
            ),
          );
          return;
        }

        if (widget.title == "My Bookings") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyBookingsScreen(),
            ),
          );
          return;
        }

        if (widget.title == "AI Assistant") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AIAssistantScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Resume Analyzer") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  ResumeAnalyzerScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Career Roadmap") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CareerSelectionScreen(),
            ),
          );
          return;
        }

        if (widget.title == "Dashboard") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MentorDashboardScreen(),
            ),
          );
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Opening ${widget.title}..."),
          ),
        );
      },
      onHover: (hovered) => setState(() => _isHovered = hovered),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered ? (Matrix4.identity()..translate(0, -4, 0)) : Matrix4.identity(),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? widget.color.withOpacity(0.6)
                : const Color(0xFF334155).withOpacity(0.5),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.color.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
              blurRadius: _isHovered ? 16 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: 22,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: widget.color.withOpacity(0.6),
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// LEARNING PROGRESS CARD
// ==========================================
class ProgressCard extends StatelessWidget {
  final UserRole role;

  const ProgressCard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final info = _getProgressInfo(role);

    return GlassContainer(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Circular Progress Indicator with Center Text
          SizedBox(
            width: 76,
            height: 76,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: info['progress'] as double,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFF1E293B),
                    valueColor: AlwaysStoppedAnimation<Color>(info['color'] as Color),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Center(
                  child: Text(
                    '${((info['progress'] as double) * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info['title'] as String,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info['subtitle'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  info['detail'] as String,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getProgressInfo(UserRole role) {
    switch (role) {
      case UserRole.student:
        return {
          'title': 'CAREER READINESS',
          'subtitle': 'Software Engineer',
          'detail': '12 Skills Completed • AI Match 72%',
          'progress': 0.72,
          'color': const Color(0xFF38BDF8),
        };
      case UserRole.jobSeeker:
        return {
          'title': 'CAREER ROADMAP',
          'subtitle': 'Full-Stack Developer',
          'detail': '15/20 Skills Completed',
          'progress': 0.75,
          'color': const Color(0xFF10B981),
        };
      case UserRole.mentor:
        return {
          'title': 'MONTHLY GOAL',
          'subtitle': 'Mentees Guided',
          'detail': '18 of 20 sessions completed',
          'progress': 0.90,
          'color': const Color(0xFFC084FC),
        };
    }
  }
}

// ==========================================
// RECOMMENDED SECTION
// ==========================================
class RecommendedSection extends StatelessWidget {
  final UserRole role;

  const RecommendedSection({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final items = _getRecommendedItems(role);

    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 260,
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 14),
            child: GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (item['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['color'] as Color,
                          size: 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['tag'] as String,
                          style: const TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['meta'] as String,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF38BDF8),
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getRecommendedItems(UserRole role) {
    switch (role) {
      case UserRole.student:
        return [
          {
            'title': 'Google Internship',
            'subtitle': 'STEP Program 2026',
            'meta': 'Remote • 12 Weeks',
            'tag': 'Stipend \$4k/m',
            'icon': Icons.g_mobiledata_rounded,
            'color': const Color(0xFFEA4335),
          },
          {
            'title': 'Microsoft SWE',
            'subtitle': 'Explore Intern',
            'meta': 'Hybrid • Bangalore',
            'tag': 'Apply Open',
            'icon': Icons.window_rounded,
            'color': const Color(0xFF00A4EF),
          },
          {
            'title': 'Amazon SDE',
            'subtitle': 'Summer Internship',
            'meta': 'Onsite • Hyderabad',
            'tag': 'High Hiring',
            'icon': Icons.shopping_bag_outlined,
            'color': const Color(0xFFFF9900),
          },
          {
            'title': 'Adobe Design',
            'subtitle': 'Product Design Intern',
            'meta': 'Remote • 8 Weeks',
            'tag': 'Design UI',
            'icon': Icons.brush_outlined,
            'color': const Color(0xFFFF0000),
          },
        ];
      case UserRole.jobSeeker:
        return [
          {
            'title': 'Software Engineer',
            'subtitle': 'Stripe • Full Time',
            'meta': '\$120k - \$150k',
            'tag': 'Urgent',
            'icon': Icons.code_rounded,
            'color': const Color(0xFF6366F1),
          },
          {
            'title': 'Frontend Developer',
            'subtitle': 'Linear • Remote',
            'meta': 'React & Flutter',
            'tag': 'Full Remote',
            'icon': Icons.web_rounded,
            'color': const Color(0xFF06B6D4),
          },
          {
            'title': 'Backend Developer',
            'subtitle': 'Notion • Hybrid',
            'meta': 'Go & PostgreSQL',
            'tag': 'Top Tier',
            'icon': Icons.dns_rounded,
            'color': const Color(0xFF10B981),
          },
          {
            'title': 'AI Engineer',
            'subtitle': 'OpenAI • Onsite',
            'meta': 'LLMs & Python',
            'tag': 'High Impact',
            'icon': Icons.memory_rounded,
            'color': const Color(0xFFA855F7),
          },
        ];
      case UserRole.mentor:
        return [
          {
            'title': 'Aarav Mehta',
            'subtitle': 'Wants Resume Review',
            'meta': 'Today at 7:00 PM',
            'tag': '15 Min',
            'icon': Icons.person_outline_rounded,
            'color': const Color(0xFF38BDF8),
          },
          {
            'title': 'Priya Sharma',
            'subtitle': 'Mock Technical Interview',
            'meta': 'Tomorrow at 4:00 PM',
            'tag': '45 Min',
            'icon': Icons.record_voice_over_outlined,
            'color': const Color(0xFFF59E0B),
          },
          {
            'title': 'Rohan Gupta',
            'subtitle': 'Career Guidance Call',
            'meta': 'Wed, 22 Jul',
            'tag': '30 Min',
            'icon': Icons.explore_outlined,
            'color': const Color(0xFF10B981),
          },
        ];
    }
  }
}

// ==========================================
// HACKATHON SECTION
// ==========================================
class HackathonSection extends StatelessWidget {
  const HackathonSection({super.key});

  final List<Map<String, String>> hackathons = const [
    {
      'title': 'Hack4Bengal 3.0',
      'date': 'July 25-27, 2026',
      'prize': '₹3,00,000 Pool',
      'image': 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&q=80&w=500',
    },
    {
      'title': 'Smart India Hackathon',
      'date': 'August 12-14, 2026',
      'prize': 'Govt Recognition',
      'image': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&q=80&w=500',
    },
    {
      'title': 'Devfolio Build-A-Thon',
      'date': 'Sept 01-03, 2026',
      'prize': '\$10,000 Prizes',
      'image': 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&q=80&w=500',
    },
    {
      'title': 'Google Solution Challenge',
      'date': 'October 10, 2026',
      'prize': 'Mentorship & Mentions',
      'image': 'https://images.unsplash.com/photo-1531482615713-2afd69097998?auto=format&fit=crop&q=80&w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: hackathons.length,
        itemBuilder: (context, index) {
          final item = hackathons[index];
          return Container(
            width: 270,
            margin: EdgeInsets.only(right: index == hackathons.length - 1 ? 0 : 14),
            child: GlassContainer(
              borderRadius: 20,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 110,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              item['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item['prize']!,
                              style: const TextStyle(
                                color: Color(0xFF38BDF8),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['date']!,
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38BDF8).withOpacity(0.2),
                              foregroundColor: const Color(0xFF38BDF8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: const Color(0xFF38BDF8).withOpacity(0.4),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Register Now',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
        },
      ),
    );
  }
}

// ==========================================
// TOP MENTORS SECTION
// ==========================================
class TopMentorsSection extends StatelessWidget {
  const TopMentorsSection({super.key});

  final List<Map<String, String>> mentors = const [
    {
      'name': 'Dr. Ananya Roy',
      'role': 'AI Researcher @ Meta',
      'exp': '10+ yrs exp',
      'rating': '4.9 ★',
      'avatar': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=250',
    },
    {
      'name': 'Vikramaditya S.',
      'role': 'Staff Engineer @ Google',
      'exp': '12+ yrs exp',
      'rating': '5.0 ★',
      'avatar': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=250',
    },
    {
      'name': 'Sarah Jenkins',
      'role': 'Product Lead @ Stripe',
      'exp': '8+ yrs exp',
      'rating': '4.8 ★',
      'avatar': 'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=250',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return Container(
            width: 230,
            margin: EdgeInsets.only(right: index == mentors.length - 1 ? 0 : 14),
            child: GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: null,
                        child: const Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mentor['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              mentor['role']!,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mentor['exp']!,
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          mentor['rating']!,
                          style: const TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF38BDF8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Session',
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// CAREER NEWS SECTION
// ==========================================
class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  final List<Map<String, String>> news = const [
    {
      'category': 'AI & TECH',
      'title': 'Generative AI Roles surge 140% in Indian Tech Hubs',
      'time': '2h ago • 3 min read',
    },
    {
      'category': 'PLACEMENTS',
      'title': 'Top 10 Tech Skills Employers Want in Late 2026',
      'time': '5h ago • 5 min read',
    },
    {
      'category': 'STARTUPS',
      'title': 'Y Combinator W26 Batch highlights Developer Tools',
      'time': '1d ago • 4 min read',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: news.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.newspaper_rounded,
                    color: Color(0xFF38BDF8),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['category']!,
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['time']!,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF475569),
                  size: 14,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ==========================================
// GLASS CONTAINER REUSABLE WIDGET
// ==========================================
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withOpacity(0.55),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? const Color(0xFF334155).withOpacity(0.4),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ==========================================
// BOTTOM NAVIGATION BAR
// ==========================================
class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.explore_outlined, 'label': 'Explore'},
      {'icon': Icons.auto_awesome_rounded, 'label': 'AI Copilot'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'Chats'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      height: 68,
      child: GlassContainer(
        borderRadius: 34,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        borderColor: const Color(0xFF38BDF8).withOpacity(0.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;
            final isAI = index == 2;

            if (isAI) {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF38BDF8), Color(0xFF818CF8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF0F172A),
                    size: 24,
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF38BDF8).withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF64748B),
                      size: 22,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Text(
                        items[index]['label'] as String,
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}