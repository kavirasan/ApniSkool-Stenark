import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_buttons.dart';
import 'lesson_screen.dart';
import 'subject_detail_screen.dart';

class CurriculumScreen extends StatelessWidget {
  const CurriculumScreen({super.key});

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
        // Hero section
        Text(
          'ACADEMIC YEAR 2024-25',
          style: SupernovaText.labelMd(CosmicPulse.primary),
        ),
        const SizedBox(height: CosmicPulse.sm),
        Text('Curriculum Directory', style: SupernovaText.headlineXl(CosmicPulse.onSurface)),
        const SizedBox(height: CosmicPulse.sm),
        Text(
          'Fuel your academic journey with the Grade 11 Supernova curriculum. Explore your subjects and track your mastery across the cosmos of knowledge.',
          style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
        ),
        const SizedBox(height: CosmicPulse.md),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: CosmicPulse.primaryFixed,
            borderRadius: CosmicPulse.brLg,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Symbols.school, color: CosmicPulse.onPrimaryFixed),
              const SizedBox(width: CosmicPulse.sm),
              Text(
                'Grade 11 Science Stream',
                style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed),
              ),
            ],
          ),
        ),
        const SizedBox(height: CosmicPulse.xl),

        _SubjectPriorityCard(
          onResume: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LessonScreen()),
          ),
        ),
        const SizedBox(height: CosmicPulse.gutter),
        _SubjectMiniCard(
          title: 'Physics',
          description: 'Laws of Motion, Work Energy Power, and Thermodynamics.',
          unitCount: '12 Units',
          iconColor: CosmicPulse.secondary,
          iconBg: const Color(0x1AB90538),
          icon: Symbols.experiment,
          tag: 'Live Class @ 4PM',
          tagColor: CosmicPulse.secondary,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SubjectDetailScreen(
                title: 'Physics',
                tagline:
                    'Laws of Motion, Work Energy Power, and Thermodynamics.',
                icon: Symbols.experiment,
                accent: CosmicPulse.secondary,
                mastery: 0.62,
                tag: 'LIVE @ 4PM',
              ),
            ),
          ),
        ),
        const SizedBox(height: CosmicPulse.md),
        _SubjectMiniCard(
          title: 'Chemistry',
          description: 'Organic Chemistry, Redox Reactions, and Chemical Bonding.',
          unitCount: '14 Units',
          iconColor: CosmicPulse.tertiary,
          iconBg: const Color(0x1A006C49),
          icon: Symbols.science,
          tag: '80% Assignment Rank',
          tagColor: CosmicPulse.tertiary,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SubjectDetailScreen(
                title: 'Chemistry',
                tagline:
                    'Organic Chemistry, Redox Reactions, and Chemical Bonding.',
                icon: Symbols.science,
                accent: CosmicPulse.tertiary,
                mastery: 0.74,
                tag: '80% RANK',
              ),
            ),
          ),
        ),
        const SizedBox(height: CosmicPulse.md),
        const _AskNovaCta(),
      ],
    );
  }
}

class _SubjectPriorityCard extends StatelessWidget {
  const _SubjectPriorityCard({required this.onResume});
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(CosmicPulse.lg),
      borderRadius: CosmicPulse.brXxl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: CosmicPulse.supernovaGradient,
                  borderRadius: CosmicPulse.brLg,
                  boxShadow: CosmicPulse.primaryGlow(blur: 12, opacity: 0.3),
                ),
                child: const Icon(Symbols.calculate, color: Colors.white, size: 32),
              ),
              const SizedBox(width: CosmicPulse.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mathematics', style: SupernovaText.headlineLg(CosmicPulse.onSurface)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('45% Course Mastery',
                            style: SupernovaText.labelSm(CosmicPulse.tertiary)),
                        const SizedBox(width: CosmicPulse.sm),
                        SizedBox(
                          width: 88,
                          height: 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: const LinearProgressIndicator(
                              value: 0.45,
                              backgroundColor: CosmicPulse.surfaceContainer,
                              valueColor: AlwaysStoppedAnimation(CosmicPulse.tertiary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.lg),
          SupernovaOutlinedButton(label: 'Resume Learning', onPressed: onResume),
          const SizedBox(height: CosmicPulse.lg),
          Text(
            'LEARNING PATH',
            style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
          ),
          const SizedBox(height: CosmicPulse.md),
          const _PathItem(
            state: _PathState.completed,
            title: 'Matrices and Determinants',
            body: 'Operations on matrices, properties of determinants, and applications in linear systems.',
            badge: 'Completed',
          ),
          const _PathItem(
            state: _PathState.inProgress,
            title: 'Vector Algebra',
            body: 'Understanding magnitude and direction, addition of vectors, and scalar multiplication.',
            badge: 'In Progress',
            footer: '144 students active now',
          ),
          const _PathItem(
            state: _PathState.locked,
            title: 'Three Dimensional Geometry',
            body: 'Prerequisite: Vector Algebra',
          ),
        ],
      ),
    );
  }
}

enum _PathState { completed, inProgress, locked }

class _PathItem extends StatelessWidget {
  const _PathItem({
    required this.state,
    required this.title,
    required this.body,
    this.badge,
    this.footer,
  });

  final _PathState state;
  final String title;
  final String body;
  final String? badge;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    late final Color dotBg;
    late final Color dotFg;
    late final IconData icon;
    late final Color cardBorder;
    late final Color cardBg;
    Color titleColor = CosmicPulse.onSurface;

    switch (state) {
      case _PathState.completed:
        dotBg = CosmicPulse.tertiaryFixed;
        dotFg = const Color(0xFF002113);
        icon = Symbols.check;
        cardBorder = const Color(0xFFE5E7EB);
        cardBg = CosmicPulse.surfaceContainerLowest;
        break;
      case _PathState.inProgress:
        dotBg = CosmicPulse.primary;
        dotFg = Colors.white;
        icon = Symbols.play_arrow;
        cardBorder = CosmicPulse.primaryContainer.withOpacity(0.3);
        cardBg = Colors.white;
        titleColor = CosmicPulse.primary;
        break;
      case _PathState.locked:
        dotBg = const Color(0xFFE2E8F0);
        dotFg = const Color(0xFF94A3B8);
        icon = Symbols.lock;
        cardBorder = const Color(0xFFE5E7EB);
        cardBg = const Color(0xFFF8FAFC);
        titleColor = CosmicPulse.onSurfaceVariant;
        break;
    }

    final content = Container(
      padding: const EdgeInsets.all(CosmicPulse.md),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: CosmicPulse.brLg,
        border: Border.all(color: cardBorder),
        boxShadow: state == _PathState.inProgress
            ? [
                BoxShadow(
                  color: CosmicPulse.primary.withOpacity(0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: SupernovaText.headlineMd(titleColor),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (state == _PathState.completed ? CosmicPulse.tertiary : CosmicPulse.primary)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge!,
                    style: SupernovaText.labelSm(
                      state == _PathState.completed ? CosmicPulse.tertiary : CosmicPulse.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: SupernovaText.bodyMd(
              state == _PathState.locked ? const Color(0xFF94A3B8) : CosmicPulse.onSurfaceVariant,
            ),
          ),
          if (footer != null) ...[
            const SizedBox(height: CosmicPulse.md),
            Text(footer!, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
          ],
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: CosmicPulse.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: dotBg, shape: BoxShape.circle),
                child: Icon(icon, color: dotFg, size: 20, fill: 1),
              ),
              if (state != _PathState.locked)
                Container(
                  width: 2,
                  height: 48,
                  margin: const EdgeInsets.only(top: 4),
                  color: state == _PathState.completed
                      ? CosmicPulse.tertiaryFixedDim.withOpacity(0.5)
                      : const Color(0xFFE2E8F0),
                ),
            ],
          ),
          const SizedBox(width: CosmicPulse.md),
          Expanded(child: content),
        ],
      ),
    );
  }
}

class _SubjectMiniCard extends StatelessWidget {
  const _SubjectMiniCard({
    required this.title,
    required this.description,
    required this.unitCount,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.tag,
    required this.tagColor,
    this.onTap,
  });

  final String title;
  final String description;
  final String unitCount;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String tag;
  final Color tagColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CosmicPulse.brXxl,
      child: GlassCard(
        borderRadius: CosmicPulse.brXxl,
        padding: const EdgeInsets.all(CosmicPulse.lg),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: iconBg, borderRadius: CosmicPulse.brLg),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const Spacer(),
              const Icon(Symbols.arrow_forward, color: Color(0xFFCBD5E1)),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(title, style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
          const SizedBox(height: 4),
          Text(description, style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant)),
          const SizedBox(height: CosmicPulse.md),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: CosmicPulse.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(unitCount, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text(tag, style: SupernovaText.labelSm(tagColor)),
                ],
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}

class _AskNovaCta extends StatelessWidget {
  const _AskNovaCta();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CosmicPulse.brXxl,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(CosmicPulse.lg),
            decoration: BoxDecoration(
              color: CosmicPulse.primaryContainer,
              borderRadius: CosmicPulse.brXxl,
              boxShadow: [
                BoxShadow(
                  color: CosmicPulse.primary.withOpacity(0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stuck on a concept?', style: SupernovaText.headlineMd(Colors.white)),
                const SizedBox(height: CosmicPulse.sm),
                Text(
                  'Our AI Tutor is ready to explain any topic with interactive visualizations.',
                  style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: CosmicPulse.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: CosmicPulse.primary,
                      shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text('Ask Nova', style: SupernovaText.labelMd(CosmicPulse.primary)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -24,
            bottom: -24,
            child: Opacity(
              opacity: 0.12,
              child: Icon(Symbols.smart_toy, size: 160, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
