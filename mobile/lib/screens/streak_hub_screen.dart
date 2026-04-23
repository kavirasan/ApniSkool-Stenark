import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/progress_orb.dart';
import '../widgets/supernova_app_bar.dart';

class StreakHubScreen extends StatelessWidget {
  const StreakHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SupernovaAppBar(
        trailing: [
          SupernovaIconAction(icon: Symbols.arrow_back, onTap: () => Navigator.of(context).maybePop()),
          const SizedBox(width: CosmicPulse.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          CosmicPulse.md,
          CosmicPulse.md,
          CosmicPulse.md,
          CosmicPulse.xl,
        ),
        children: [
          Text('Ready for lift-off, Alex?', style: SupernovaText.headlineXl(CosmicPulse.onSurface)),
          const SizedBox(height: CosmicPulse.xs),
          Text(
            "Your exam is in 14 days. Let's maximize your momentum today with targeted practice sessions.",
            style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
          ),
          const SizedBox(height: CosmicPulse.xl),

          const _StreakCalendarCard(),
          const SizedBox(height: CosmicPulse.gutter),

          const _WeeklyMasteryCard(),
          const SizedBox(height: CosmicPulse.gutter),

          _SectionTitle(),
          const SizedBox(height: CosmicPulse.md),
          const _FastTrackCard(
            icon: Symbols.history_edu,
            accent: CosmicPulse.primary,
            title: '10-Year Question Bank',
            body:
                'Aggregated high-yield questions from the last decade with step-by-step video solutions.',
            ctaLabel: 'Start Solving',
            ctaIcon: Symbols.arrow_forward,
          ),
          const SizedBox(height: CosmicPulse.md),
          const _FastTrackCard(
            icon: Symbols.verified_user,
            accent: CosmicPulse.secondary,
            title: 'Score 50 Marks for Sure',
            body:
                'Hand-picked "Guaranteed Topics" based on statistical recurrence models for the 2024 Exam.',
            ctaLabel: 'Unlock Insights',
            ctaIcon: Symbols.bolt,
            leftBorder: true,
          ),
          const SizedBox(height: CosmicPulse.gutter),

          const _UpcomingLecturesCard(),
        ],
      ),
    );
  }
}

class _StreakCalendarCard extends StatelessWidget {
  const _StreakCalendarCard();

  // 30-day streak bitmap from the design
  static const _days = <bool>[
    false, false, true, true, true, false, false,
    true, true, true, true, true, true, true,
    true, true, true, true, true, false, false,
    true, true, true, true, true, true, true,
    true, true,
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DAILY STREAK', style: SupernovaText.labelMd(CosmicPulse.primary)),
              Row(
                children: [
                  const Icon(Symbols.local_fire_department,
                      color: CosmicPulse.secondary, fill: 1, size: 20),
                  const SizedBox(width: 4),
                  Text('12 Days',
                      style: SupernovaText.labelMd(CosmicPulse.secondary).copyWith(fontSize: 15)),
                ],
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final active in _days)
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: active ? CosmicPulse.supernovaGradient : null,
                      color: active ? null : CosmicPulse.surfaceContainerHighest.withOpacity(0.5),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                color: CosmicPulse.primary.withOpacity(0.25),
                                blurRadius: 6,
                              )
                            ]
                          : null,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(
            'Consistent study for 30 mins/day maintains your streak!',
            style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _WeeklyMasteryCard extends StatelessWidget {
  const _WeeklyMasteryCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Mastery Progress', style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
          const SizedBox(height: CosmicPulse.lg),
          const Wrap(
            alignment: WrapAlignment.spaceAround,
            runSpacing: CosmicPulse.lg,
            children: [
              ProgressOrb(progress: 0.75, label: 'Physics', color: CosmicPulse.primary),
              ProgressOrb(progress: 0.40, label: 'Chemistry', color: CosmicPulse.tertiary),
              ProgressOrb(progress: 0.90, label: 'Biology', color: CosmicPulse.secondary),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Mastery Fast Track', style: SupernovaText.headlineLg(CosmicPulse.onSurface)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: CosmicPulse.tertiary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text('Boosted Results', style: SupernovaText.labelSm(CosmicPulse.tertiary)),
        ),
      ],
    );
  }
}

class _FastTrackCard extends StatelessWidget {
  const _FastTrackCard({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
    required this.ctaLabel,
    required this.ctaIcon,
    this.leftBorder = false,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String body;
  final String ctaLabel;
  final IconData ctaIcon;
  final bool leftBorder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassCard(
          borderRadius: CosmicPulse.brXxl,
          padding: const EdgeInsets.all(CosmicPulse.lg + CosmicPulse.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: CosmicPulse.brLg,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, fill: 1, size: 28),
              ),
              const SizedBox(height: CosmicPulse.md),
              Text(title, style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
              const SizedBox(height: CosmicPulse.xs),
              Text(body, style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant)),
              const SizedBox(height: CosmicPulse.lg),
              Row(
                children: [
                  Text(
                    ctaLabel,
                    style: SupernovaText.labelMd(accent)
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: CosmicPulse.sm),
                  Icon(ctaIcon, color: accent, size: 20),
                ],
              ),
            ],
          ),
        ),
        if (leftBorder)
          Positioned(
            left: 0,
            top: 12,
            bottom: 12,
            child: Container(width: 4, color: accent),
          ),
        Positioned(
          right: -40,
          top: -40,
          child: IgnorePointer(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UpcomingLecturesCard extends StatelessWidget {
  const _UpcomingLecturesCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Upcoming Lectures',
                    style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
              ),
              Row(
                children: [
                  Text(
                    'View Schedule',
                    style: SupernovaText.labelMd(CosmicPulse.primary)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Symbols.calendar_today, color: CosmicPulse.primary, size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.lg),
          const _LectureTile(
            time: '14:00',
            title: 'Advanced Thermodynamics - Entropy Deep Dive',
            subtitle: 'Dr. Sarah Thompson • Live in 45 mins',
            primaryCta: true,
          ),
          const SizedBox(height: CosmicPulse.sm + 4),
          const _LectureTile(
            time: '16:30',
            title: 'Organic Chemistry: Carbonyl Compounds',
            subtitle: 'Prof. Michael Chen • Pre-recorded',
            primaryCta: false,
          ),
        ],
      ),
    );
  }
}

class _LectureTile extends StatelessWidget {
  const _LectureTile({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.primaryCta,
  });

  final String time;
  final String title;
  final String subtitle;
  final bool primaryCta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CosmicPulse.md - 4),
      decoration: BoxDecoration(
        color: CosmicPulse.surfaceContainer,
        borderRadius: CosmicPulse.brLg,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryCta ? CosmicPulse.primaryContainer : CosmicPulse.tertiaryContainer,
              borderRadius: CosmicPulse.brMd,
            ),
            child: Text(
              time,
              style: SupernovaText.labelMd(Colors.white).copyWith(fontSize: 13),
            ),
          ),
          const SizedBox(width: CosmicPulse.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: SupernovaText.labelMd(CosmicPulse.onSurface)),
                const SizedBox(height: 2),
                Text(subtitle, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(width: CosmicPulse.sm),
          primaryCta
              ? ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosmicPulse.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brMd),
                  ),
                  child: Text('Join Room',
                      style: SupernovaText.labelMd(Colors.white).copyWith(fontSize: 12)),
                )
              : OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CosmicPulse.primary,
                    side: const BorderSide(color: CosmicPulse.primary, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brMd),
                  ),
                  child: Text('Watch Now',
                      style: SupernovaText.labelMd(CosmicPulse.primary).copyWith(fontSize: 12)),
                ),
        ],
      ),
    );
  }
}
