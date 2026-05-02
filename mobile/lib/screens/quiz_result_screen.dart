import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_buttons.dart';
import '../widgets/supernova_lottie.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({
    super.key,
    this.correct = 8,
    this.total = 10,
    this.timeTaken = const Duration(minutes: 12, seconds: 34),
  });

  final int correct;
  final int total;
  final Duration timeTaken;

  bool get _passed => correct / total >= 0.6;

  @override
  Widget build(BuildContext context) {
    final accuracy = correct / total;
    return Scaffold(
      appBar: SupernovaAppBar(
        title: 'Quiz Result',
        trailing: [
          SupernovaIconAction(
            icon: Symbols.close,
            onTap: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: CosmicPulse.xs),
        ],
      ),
      body: Stack(
        children: [
          if (_passed)
            // Confetti is purely decorative and pointer-disabled so it never
            // blocks UI interactions or scrolling underneath.
            Positioned.fill(
              child: IgnorePointer(
                child: SupernovaLottie.asset(
                  SupernovaAnimations.confetti,
                  speed: 0.85,
                  repeat: false,
                  fit: BoxFit.cover,
                  fallback: const SizedBox.shrink(),
                ),
              ),
            ),
          ListView(
            padding: const EdgeInsets.fromLTRB(
              CosmicPulse.md,
              CosmicPulse.md,
              CosmicPulse.md,
              CosmicPulse.xl,
            ),
            children: [
              _Hero(passed: _passed, accuracy: accuracy),
              const SizedBox(height: CosmicPulse.gutter),
              _ScoreBreakdown(
                correct: correct,
                total: total,
                timeTaken: timeTaken,
              ),
              const SizedBox(height: CosmicPulse.gutter),
              const _AiInsightCard(),
              const SizedBox(height: CosmicPulse.gutter),
              _Actions(
                onReview: () => Navigator.of(context).maybePop(),
                onRetake: () => Navigator.of(context).maybePop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.passed, required this.accuracy});

  final bool passed;
  final double accuracy;

  @override
  Widget build(BuildContext context) {
    final hueA = passed ? CosmicPulse.primary : CosmicPulse.secondary;
    final hueB =
        passed ? CosmicPulse.primaryContainer : CosmicPulse.secondaryContainer;
    return Container(
      padding: const EdgeInsets.all(CosmicPulse.lg + CosmicPulse.xs),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [hueA, hueB],
        ),
        borderRadius: CosmicPulse.brXxl,
        boxShadow: [
          BoxShadow(
            color: hueA.withOpacity(0.35),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          SupernovaLottie.asset(
            passed
                ? SupernovaAnimations.trophy
                : SupernovaAnimations.tryAgain,
            size: 160,
            repeat: !passed,
            fallback: PulseRing(
              color: Colors.white,
              icon: passed ? Symbols.emoji_events : Symbols.refresh,
              size: 120,
            ),
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(
            passed ? 'Stellar work!' : 'So close!',
            style: SupernovaText.headlineXl(Colors.white),
          ),
          const SizedBox(height: CosmicPulse.xs),
          Text(
            passed
                ? 'You crushed this set with strong concept clarity.'
                : 'Review the misses below — Nova will guide you.',
            style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CosmicPulse.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CosmicPulse.lg,
              vertical: CosmicPulse.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${(accuracy * 100).round()}% accuracy',
              style: SupernovaText.labelMd(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreBreakdown extends StatelessWidget {
  const _ScoreBreakdown({
    required this.correct,
    required this.total,
    required this.timeTaken,
  });

  final int correct;
  final int total;
  final Duration timeTaken;

  String get _timeLabel {
    final m = timeTaken.inMinutes;
    final s = timeTaken.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final wrong = total - correct;
    return GlassCard(
      borderRadius: CosmicPulse.brXxl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SCORE BREAKDOWN',
              style: SupernovaText.labelMd(CosmicPulse.primary)),
          const SizedBox(height: CosmicPulse.md),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  icon: Symbols.check_circle,
                  color: CosmicPulse.tertiary,
                  value: '$correct',
                  label: 'Correct',
                ),
              ),
              Expanded(
                child: _MiniStat(
                  icon: Symbols.cancel,
                  color: CosmicPulse.secondary,
                  value: '$wrong',
                  label: 'Missed',
                ),
              ),
              Expanded(
                child: _MiniStat(
                  icon: Symbols.timer,
                  color: CosmicPulse.primary,
                  value: _timeLabel,
                  label: 'Time',
                ),
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.lg),
          Text(
            'Accuracy vs class average',
            style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
          ),
          const SizedBox(height: CosmicPulse.sm),
          GradientProgressBar(progress: correct / total),
          const SizedBox(height: CosmicPulse.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You: ${(correct / total * 100).round()}%',
                  style: SupernovaText.labelSm(CosmicPulse.primary)),
              Text('Class avg: 64%',
                  style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: CosmicPulse.brMd,
          ),
          child: Icon(icon, color: color, size: 24, fill: 1),
        ),
        const SizedBox(height: CosmicPulse.xs + 2),
        Text(value, style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
        Text(label, style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
      ],
    );
  }
}

class _AiInsightCard extends StatelessWidget {
  const _AiInsightCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [CosmicPulse.tertiary, CosmicPulse.tertiaryContainer],
        ),
        borderRadius: CosmicPulse.brXxl,
      ),
      child: Container(
        padding: const EdgeInsets.all(CosmicPulse.lg),
        decoration: const BoxDecoration(
          color: CosmicPulse.surfaceContainerLowest,
          borderRadius: CosmicPulse.brXl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SupernovaLottie.asset(
                  SupernovaAnimations.aiOrb,
                  size: 36,
                  fallback: PulseRing(
                    color: CosmicPulse.tertiary,
                    icon: Symbols.smart_toy,
                    size: 36,
                  ),
                ),
                const SizedBox(width: CosmicPulse.sm),
                Text("NOVA'S TAKEAWAY",
                    style: SupernovaText.labelMd(CosmicPulse.tertiary)),
              ],
            ),
            const SizedBox(height: CosmicPulse.md),
            Text(
              'Strong on conceptual prompts, weaker on numerical edge cases. '
              'Practice 5 problems on uncertainty bounds tomorrow to lock it in.',
              style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.onReview, required this.onRetake});
  final VoidCallback onReview;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SupernovaOutlinedButton(
            label: 'Review Answers',
            onPressed: onReview,
          ),
        ),
        const SizedBox(width: CosmicPulse.md),
        Expanded(
          child: SupernovaPrimaryButton(
            label: 'Retake Quiz',
            onPressed: onRetake,
            icon: Symbols.refresh,
            expand: true,
          ),
        ),
      ],
    );
  }
}
