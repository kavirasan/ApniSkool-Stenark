import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/supernova_buttons.dart';
import '../widgets/supernova_lottie.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pages = PageController();
  int _index = 0;

  static const _slides = <_OnboardingSlide>[
    _OnboardingSlide(
      animation: SupernovaAnimations.aiOrb,
      fallbackIcon: Symbols.smart_toy,
      fallbackColor: CosmicPulse.primary,
      eyebrow: 'AI TUTOR',
      title: 'Nova explains anything',
      body:
          'Tap any topic and Nova breaks it down with diagrams, analogies and worked examples.',
    ),
    _OnboardingSlide(
      animation: SupernovaAnimations.streakFire,
      fallbackIcon: Symbols.local_fire_department,
      fallbackColor: CosmicPulse.secondary,
      eyebrow: 'DAILY STREAKS',
      title: 'Build momentum that sticks',
      body:
          'Just 30 minutes a day keeps your streak alive and unlocks tier-based perks.',
    ),
    _OnboardingSlide(
      animation: SupernovaAnimations.trophy,
      fallbackIcon: Symbols.workspace_premium,
      fallbackColor: CosmicPulse.tertiary,
      eyebrow: 'EXAM-READY',
      title: 'Master what matters',
      body:
          'Curated high-yield questions, 10-year archives and AI-recommended quizzes.',
    ),
  ];

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _toLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 360),
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _next() {
    if (_index >= _slides.length - 1) {
      _toLogin();
      return;
    }
    _pages.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _slides.length - 1;
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CosmicPulse.md,
                CosmicPulse.sm,
                CosmicPulse.md,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _toLogin,
                    style: TextButton.styleFrom(
                      foregroundColor: CosmicPulse.onSurfaceVariant,
                    ),
                    child: Text(
                      'Skip',
                      style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pages,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlideView(slide: _slides[i]),
              ),
            ),
            _DotsIndicator(count: _slides.length, current: _index),
            const SizedBox(height: CosmicPulse.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CosmicPulse.md),
              child: SizedBox(
                width: double.infinity,
                child: SupernovaPrimaryButton(
                  label: isLast ? 'Get Started' : 'Next',
                  icon: isLast ? Symbols.rocket_launch : Symbols.arrow_forward,
                  onPressed: _next,
                  expand: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: CosmicPulse.lg),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.animation,
    required this.fallbackIcon,
    required this.fallbackColor,
    required this.eyebrow,
    required this.title,
    required this.body,
  });
  final String animation;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final String eyebrow;
  final String title;
  final String body;
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide});
  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CosmicPulse.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SupernovaLottie.asset(
            slide.animation,
            size: 220,
            fallback: PulseRing(
              color: slide.fallbackColor,
              icon: slide.fallbackIcon,
              size: 180,
            ),
          ),
          const SizedBox(height: CosmicPulse.xl),
          Text(
            slide.eyebrow,
            style: SupernovaText.labelMd(slide.fallbackColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CosmicPulse.sm),
          Text(
            slide.title,
            style: SupernovaText.headlineLg(CosmicPulse.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(
            slide.body,
            style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.count, required this.current});
  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? CosmicPulse.primary : CosmicPulse.outlineVariant,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
