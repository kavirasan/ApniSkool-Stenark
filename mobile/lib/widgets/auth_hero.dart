import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';
import 'supernova_lottie.dart';

/// Gradient hero panel used at the top of every auth screen so login, signup
/// and OTP all share the same visual anchor. Wraps the Lottie orb with a
/// graceful fallback so it never blocks the screen.
class AuthHero extends StatelessWidget {
  const AuthHero({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.heroSize = 120,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final double heroSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
            CosmicPulse.lg,
            CosmicPulse.xl,
            CosmicPulse.lg,
            CosmicPulse.lg + CosmicPulse.md,
          ),
          decoration: const BoxDecoration(
            gradient: CosmicPulse.supernovaGradient,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              SupernovaLottie.asset(
                SupernovaAnimations.aiOrb,
                size: heroSize,
                fallback: PulseRing(
                  color: Colors.white,
                  size: heroSize,
                ),
              ),
              const SizedBox(height: CosmicPulse.md),
              Text(
                eyebrow.toUpperCase(),
                style: SupernovaText.labelMd(Colors.white.withOpacity(0.85)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CosmicPulse.xs + 2),
              Text(
                title,
                style: SupernovaText.headlineXl(Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CosmicPulse.xs),
              Text(
                subtitle,
                style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Wraps any auth body content with a single fade + slide entrance so the
/// transition from app launch / nav push feels deliberate without compounding
/// per-widget animation cost.
class AuthEnterAnimation extends StatelessWidget {
  const AuthEnterAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
      builder: (_, t, c) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 16),
            child: c,
          ),
        );
      },
      child: child,
    );
  }
}
