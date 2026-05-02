import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import '../widgets/supernova_buttons.dart';
import '../widgets/supernova_lottie.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';
import 'streak_hub_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
        // Hero welcome
        Text('Hello, Arjun!', style: SupernovaText.headlineXl(CosmicPulse.primary)),
        const SizedBox(height: CosmicPulse.xs),
        Text(
          'Your supernova journey is 68% complete today.',
          style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
        ),
        const SizedBox(height: CosmicPulse.lg),

        // Physics progress card
        _PhysicsProgressCard(
          onResume: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LessonScreen()),
          ),
        ),
        const SizedBox(height: CosmicPulse.gutter),

        // Streak card
        _StreakCard(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const StreakHubScreen()),
          ),
        ),
        const SizedBox(height: CosmicPulse.gutter),

        // Weekly focus
        const _WeeklyFocusCard(),
        const SizedBox(height: CosmicPulse.gutter),

        // AI Recommended Quiz
        _AIQuizCard(
          onStart: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          ),
        ),
      ],
    );
  }
}

class _PhysicsProgressCard extends StatelessWidget {
  const _PhysicsProgressCard({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(CosmicPulse.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: CosmicPulse.primaryContainer.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'CURRENT FOCUS',
                            style: SupernovaText.labelMd(CosmicPulse.primary),
                          ),
                        ),
                        const SizedBox(height: CosmicPulse.sm),
                        Text('Physics', style: SupernovaText.headlineLg(CosmicPulse.onSurface)),
                        const SizedBox(height: 2),
                        Text(
                          'Quantum Mechanics: Wave-Particle Duality',
                          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('74%', style: SupernovaText.headlineMd(CosmicPulse.primary)),
                      const SizedBox(height: 2),
                      Text('Course Progress', style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: CosmicPulse.lg),
              const GradientProgressBar(progress: 0.74, height: 14),
              const SizedBox(height: CosmicPulse.md),
              Row(
                children: [
                  const _StackedAvatars(),
                  const Spacer(),
                  SupernovaPrimaryButton(
                    label: 'Resume Lesson',
                    onPressed: onResume,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.08,
              child: Icon(Symbols.rocket_launch, size: 120, color: CosmicPulse.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 32,
      child: Stack(
        children: [
          _avatarCircle(icon: Symbols.menu_book, left: 0),
          _avatarCircle(icon: Symbols.play_circle, left: 20),
        ],
      ),
    );
  }

  Widget _avatarCircle({required IconData icon, required double left}) {
    return Positioned(
      left: left,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CosmicPulse.surfaceContainerHigh,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(icon, size: 16, color: CosmicPulse.onSurfaceVariant),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CosmicPulse.brLg,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: CosmicPulse.brLg,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [CosmicPulse.secondary, CosmicPulse.secondaryContainer],
          ),
          boxShadow: [
            BoxShadow(
              color: CosmicPulse.secondary.withOpacity(0.3),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(CosmicPulse.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: SupernovaLottie.asset(
                      SupernovaAnimations.streakFire,
                      size: 48,
                      fallback: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: CosmicPulse.brLg,
                        ),
                        child: const Icon(
                          Symbols.local_fire_department,
                          color: Colors.white,
                          fill: 1,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('ELITE TIER', style: SupernovaText.labelMd(Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: CosmicPulse.xl),
              Text('14 Day Streak', style: SupernovaText.headlineXl(Colors.white)),
              const SizedBox(height: CosmicPulse.sm),
              Text(
                "You're in the top 5% of students this week!",
                style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeeklyFocusCard extends StatelessWidget {
  const _WeeklyFocusCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Symbols.target, color: CosmicPulse.tertiary),
              const SizedBox(width: CosmicPulse.sm),
              Text(
                'WEEKLY FOCUS',
                style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          _FocusTile(
            icon: Symbols.check_circle,
            iconColor: CosmicPulse.tertiary,
            iconBg: CosmicPulse.tertiary.withOpacity(0.1),
            title: 'Calculus Mastery',
            subtitle: '3/4 Lessons completed',
          ),
          const SizedBox(height: CosmicPulse.md),
          Opacity(
            opacity: 0.6,
            child: _FocusTile(
              icon: Symbols.radio_button_unchecked,
              iconColor: CosmicPulse.outline,
              iconBg: CosmicPulse.surfaceContainer,
              title: 'Organic Chemistry Lab',
              subtitle: 'Scheduled for Friday',
              dashed: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusTile extends StatelessWidget {
  const _FocusTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.dashed = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
            border: dashed
                ? Border.all(color: CosmicPulse.outline, width: 2, style: BorderStyle.solid)
                : null,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: CosmicPulse.md - 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: SupernovaText.bodyMd(CosmicPulse.onSurface).copyWith(fontWeight: FontWeight.w700),
              ),
              Text(subtitle, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}

class _AIQuizCard extends StatelessWidget {
  const _AIQuizCard({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: CosmicPulse.primaryContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CosmicPulse.primaryContainer.withOpacity(0.2),
                  CosmicPulse.primary.withOpacity(0.9),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SupernovaLottie.asset(
                    SupernovaAnimations.aiOrb,
                    size: 96,
                    fallback: Icon(
                      Symbols.auto_awesome,
                      size: 72,
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                ),
                Positioned(
                  left: CosmicPulse.md,
                  bottom: CosmicPulse.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('AI RECOMMENDED', style: SupernovaText.labelMd(CosmicPulse.primary)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(CosmicPulse.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Symbols.smart_toy, size: 16, color: CosmicPulse.primary),
                    const SizedBox(width: CosmicPulse.xs),
                    Text('Supernova AI Insight', style: SupernovaText.labelSm(CosmicPulse.primary)),
                  ],
                ),
                const SizedBox(height: CosmicPulse.sm),
                Text('Waves & Optics Challenge',
                    style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
                const SizedBox(height: CosmicPulse.sm),
                Text(
                  'Based on your recent Physics performance, this quiz will help solidify your understanding of diffraction patterns.',
                  style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                ),
                const SizedBox(height: CosmicPulse.md),
                Row(
                  children: [
                    const _IconLabel(icon: Symbols.schedule, label: '15 Mins'),
                    const SizedBox(width: CosmicPulse.md),
                    const _IconLabel(icon: Symbols.quiz, label: '10 Qs'),
                    const Spacer(),
                    SupernovaOutlinedButton(label: 'Start Quiz', onPressed: onStart),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: CosmicPulse.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(label, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
      ],
    );
  }
}
