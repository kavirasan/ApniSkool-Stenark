import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_bottom_nav.dart';
import 'ai_tutor_screen.dart';
import 'curriculum_screen.dart';
import 'dashboard_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'questions_hub_screen.dart';
import 'search_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  static const _tabs = <Widget>[
    DashboardScreen(),
    CurriculumScreen(),
    AITutorScreen(),
    QuestionsHubScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      appBar: SupernovaAppBar(
        trailing: [
          SupernovaIconAction(
            icon: Symbols.search,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
          SupernovaIconAction(
            icon: Symbols.notifications,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          SupernovaIconAction(
            icon: Symbols.account_circle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      extendBody: true,
      body: Stack(
        children: [
          // Soft background accents.
          Positioned(
            top: -80,
            right: -80,
            child: _bgBlob(CosmicPulse.primary.withOpacity(0.05), 280),
          ),
          Positioned(
            bottom: 80,
            left: -80,
            child: _bgBlob(CosmicPulse.secondary.withOpacity(0.05), 220),
          ),
          SafeArea(
            bottom: false,
            // IndexedStack keeps each tab's state alive but only the visible
            // tab paints — Lottie controllers in offscreen tabs stay paused.
            child: IndexedStack(
              index: _tab,
              children: _tabs,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SupernovaBottomNav(
        currentIndex: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
    );
  }

  Widget _bgBlob(Color color, double size) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
