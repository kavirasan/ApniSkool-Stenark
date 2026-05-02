import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/supernova_lottie.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    Timer(const Duration(milliseconds: 1600), _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, __, ___) => const OnboardingScreen(),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: CosmicPulse.supernovaGradient),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _c,
              builder: (_, child) {
                final t = Curves.easeOutCubic.transform(_c.value);
                return Opacity(
                  opacity: t,
                  child: Transform.scale(scale: 0.92 + 0.08 * t, child: child),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SupernovaLottie.asset(
                    SupernovaAnimations.aiOrb,
                    size: 160,
                    fallback: PulseRing(color: Colors.white, size: 140),
                  ),
                  const SizedBox(height: CosmicPulse.lg),
                  Text(
                    'Kalvi Supernova',
                    style: SupernovaText.headlineXl(Colors.white),
                  ),
                  const SizedBox(height: CosmicPulse.xs),
                  Text(
                    'Learn at the speed of light.',
                    style: SupernovaText.bodyMd(Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
