import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_bottom_nav.dart';
import 'curriculum_screen.dart';
import 'dashboard_screen.dart';
import 'lesson_screen.dart';
import 'questions_hub_screen.dart';

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
    _AITutorTab(),
    QuestionsHubScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      appBar: const SupernovaAppBar(),
      extendBody: true,
      body: Stack(
        children: [
          // Soft background accents
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

class _AITutorTab extends StatelessWidget {
  const _AITutorTab();

  @override
  Widget build(BuildContext context) {
    // AI Tutor entry-point — render the lesson view within the shell body.
    // The standalone LessonScreen also wraps a Scaffold; here we just render its
    // content inside the shell by pushing it on first open.
    return const _AITutorLanding();
  }
}

class _AITutorLanding extends StatelessWidget {
  const _AITutorLanding();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        CosmicPulse.md,
        CosmicPulse.md,
        CosmicPulse.md,
        CosmicPulse.xl,
      ),
      children: [
        Text('AI Tutor', style: SupernovaText.headlineXl(CosmicPulse.primary)),
        const SizedBox(height: CosmicPulse.xs),
        Text(
          'Nova is standing by to explain concepts, unpack diagrams, and walk you through solved problems.',
          style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
        ),
        const SizedBox(height: CosmicPulse.lg),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LessonScreen()),
          ),
          borderRadius: CosmicPulse.brXl,
          child: Ink(
            padding: const EdgeInsets.all(CosmicPulse.lg),
            decoration: BoxDecoration(
              gradient: CosmicPulse.supernovaGradient,
              borderRadius: CosmicPulse.brXl,
              boxShadow: [
                BoxShadow(
                  color: CosmicPulse.primary.withOpacity(0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Continue Quantum Mechanics', style: SupernovaText.headlineMd(Colors.white)),
                const SizedBox(height: CosmicPulse.xs),
                Text(
                  'Module 4: Wave-Particle Duality • 66% complete',
                  style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: CosmicPulse.md),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: CosmicPulse.brLg,
                  ),
                  child: Text('Resume with Nova',
                      style: SupernovaText.labelMd(CosmicPulse.primary)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
