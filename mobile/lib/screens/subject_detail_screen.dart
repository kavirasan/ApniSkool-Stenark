import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_buttons.dart';
import '../widgets/supernova_lottie.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({
    super.key,
    required this.title,
    required this.tagline,
    required this.icon,
    required this.accent,
    required this.mastery,
    this.tag,
  });

  final String title;
  final String tagline;
  final IconData icon;
  final Color accent;
  final double mastery;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      appBar: SupernovaAppBar(
        title: title,
        trailing: [
          SupernovaIconAction(
            icon: Symbols.arrow_back,
            onTap: () => Navigator.of(context).maybePop(),
          ),
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
          _SubjectHero(
            title: title,
            tagline: tagline,
            icon: icon,
            accent: accent,
            mastery: mastery,
            tag: tag,
          ),
          const SizedBox(height: CosmicPulse.gutter),
          _UnitsCard(accent: accent),
          const SizedBox(height: CosmicPulse.gutter),
          _QuickActions(
            accent: accent,
            onResume: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LessonScreen()),
            ),
            onQuiz: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectHero extends StatelessWidget {
  const _SubjectHero({
    required this.title,
    required this.tagline,
    required this.icon,
    required this.accent,
    required this.mastery,
    required this.tag,
  });

  final String title;
  final String tagline;
  final IconData icon;
  final Color accent;
  final double mastery;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CosmicPulse.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent, accent.withOpacity(0.75)],
        ),
        borderRadius: CosmicPulse.brXxl,
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.3),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: SupernovaLottie.asset(
                  SupernovaAnimations.aiOrb,
                  size: 64,
                  fallback: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: CosmicPulse.brLg,
                    ),
                    child: Icon(icon, color: Colors.white, size: 32, fill: 1),
                  ),
                ),
              ),
              const Spacer(),
              if (tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CosmicPulse.md,
                    vertical: CosmicPulse.xs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    tag!,
                    style: SupernovaText.labelMd(Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(title, style: SupernovaText.headlineXl(Colors.white)),
          const SizedBox(height: CosmicPulse.xs),
          Text(
            tagline,
            style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: CosmicPulse.lg),
          GradientProgressBar(
            progress: mastery,
            height: 10,
            backgroundColor: Colors.white.withOpacity(0.18),
            gradient: const LinearGradient(colors: [Colors.white, Colors.white]),
            glowColor: Colors.white,
          ),
          const SizedBox(height: CosmicPulse.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(mastery * 100).round()}% mastery',
                style: SupernovaText.labelSm(Colors.white),
              ),
              Text(
                'Class avg: 58%',
                style: SupernovaText.labelSm(Colors.white.withOpacity(0.85)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UnitsCard extends StatelessWidget {
  const _UnitsCard({required this.accent});
  final Color accent;

  static const _units = <_UnitData>[
    _UnitData('Unit 1', 'Foundations', 1.0, true),
    _UnitData('Unit 2', 'Core principles', 0.8, true),
    _UnitData('Unit 3', 'Applied problems', 0.45, false),
    _UnitData('Unit 4', 'Advanced topics', 0.0, false),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brXxl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UNITS', style: SupernovaText.labelMd(accent)),
          const SizedBox(height: CosmicPulse.md),
          for (int i = 0; i < _units.length; i++) ...[
            _UnitRow(unit: _units[i], accent: accent),
            if (i != _units.length - 1) const SizedBox(height: CosmicPulse.md),
          ],
        ],
      ),
    );
  }
}

class _UnitData {
  const _UnitData(this.code, this.title, this.progress, this.unlocked);
  final String code;
  final String title;
  final double progress;
  final bool unlocked;
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit, required this.accent});
  final _UnitData unit;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final locked = !unit.unlocked;
    final done = unit.progress >= 1.0;
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: locked
                ? CosmicPulse.surfaceContainerHighest
                : accent.withOpacity(0.12),
            borderRadius: CosmicPulse.brMd,
          ),
          alignment: Alignment.center,
          child: Icon(
            locked
                ? Symbols.lock
                : (done ? Symbols.check_circle : Symbols.play_arrow),
            color: locked ? CosmicPulse.outline : accent,
            fill: 1,
            size: 22,
          ),
        ),
        const SizedBox(width: CosmicPulse.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.code,
                style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant),
              ),
              Text(
                unit.title,
                style: SupernovaText.bodyMd(
                  locked ? CosmicPulse.onSurfaceVariant : CosmicPulse.onSurface,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              GradientProgressBar(
                progress: unit.progress,
                height: 6,
                gradient: LinearGradient(colors: [accent, accent]),
                glowColor: accent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.accent,
    required this.onResume,
    required this.onQuiz,
  });
  final Color accent;
  final VoidCallback onResume;
  final VoidCallback onQuiz;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SupernovaOutlinedButton(label: 'Take Quiz', onPressed: onQuiz),
        ),
        const SizedBox(width: CosmicPulse.md),
        Expanded(
          child: SupernovaPrimaryButton(
            label: 'Resume Learning',
            icon: Symbols.arrow_forward,
            onPressed: onResume,
            expand: true,
          ),
        ),
      ],
    );
  }
}
