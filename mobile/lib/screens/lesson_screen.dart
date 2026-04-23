import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_app_bar.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SupernovaAppBar(
        trailing: [
          SupernovaIconAction(icon: Symbols.search, onTap: () {}),
          SupernovaIconAction(icon: Symbols.close, onTap: () => Navigator.of(context).maybePop()),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(
              CosmicPulse.md,
              CosmicPulse.md,
              CosmicPulse.md,
              120,
            ),
            children: [
              _VideoPlayer(
                playing: _playing,
                onToggle: () => setState(() => _playing = !_playing),
              ),
              const SizedBox(height: CosmicPulse.md),
              Text('Wave-Particle Duality',
                  style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
              const SizedBox(height: CosmicPulse.sm),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: CosmicPulse.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('High Priority', style: SupernovaText.labelSm(Colors.white)),
                  ),
                  const SizedBox(width: CosmicPulse.sm),
                  Text('Updated 2h ago',
                      style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: CosmicPulse.gutter),
              const _KeyTakeawaysCard(),
              const SizedBox(height: CosmicPulse.md),
              const _NextUpCard(),
            ],
          ),
          const Positioned(
            right: CosmicPulse.md,
            bottom: CosmicPulse.md + 16,
            child: _AskAITutorButton(),
          ),
        ],
      ),
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({required this.playing, required this.onToggle});

  final bool playing;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CosmicPulse.brXxl,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CosmicPulse.inverseSurface, CosmicPulse.primary],
                ),
              ),
              child: Center(
                child: Icon(
                  Symbols.auto_awesome,
                  color: Colors.white.withOpacity(0.25),
                  size: 96,
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: onToggle,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: CosmicPulse.primary.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CosmicPulse.primary.withOpacity(0.4),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: Icon(
                    playing ? Symbols.pause : Symbols.play_arrow,
                    color: Colors.white,
                    fill: 1,
                    size: 40,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(CosmicPulse.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Symbols.hd, color: Colors.white, size: 16),
                        const SizedBox(width: CosmicPulse.sm),
                        Expanded(
                          child: Text(
                            'Quantum Mechanics: Module 4',
                            style: SupernovaText.labelSm(Colors.white),
                          ),
                        ),
                        const Icon(Symbols.settings, color: Colors.white, size: 20),
                        const SizedBox(width: CosmicPulse.md),
                        const Icon(Symbols.fullscreen, color: Colors.white, size: 20),
                      ],
                    ),
                    const SizedBox(height: CosmicPulse.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: 0.66,
                        minHeight: 4,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation(CosmicPulse.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyTakeawaysCard extends StatelessWidget {
  const _KeyTakeawaysCard();

  @override
  Widget build(BuildContext context) {
    const takeaways = [
      'Everything exhibits both wave and particle properties simultaneously.',
      'The observer effect: measurement collapses the wave function.',
      "Schrödinger's Equation describes how states change over time.",
    ];

    return GlassCard(
      borderRadius: CosmicPulse.brXxl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Symbols.auto_awesome, color: CosmicPulse.primary),
              const SizedBox(width: CosmicPulse.sm),
              Text('KEY TAKEAWAYS', style: SupernovaText.labelMd(CosmicPulse.primary)),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          for (int i = 0; i < takeaways.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: CosmicPulse.surfaceContainer,
                    borderRadius: CosmicPulse.brMd,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: SupernovaText.labelMd(CosmicPulse.primary),
                  ),
                ),
                const SizedBox(width: CosmicPulse.md),
                Expanded(
                  child: Text(
                    takeaways[i],
                    style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            if (i != takeaways.length - 1) const SizedBox(height: CosmicPulse.md),
          ],
          const SizedBox(height: CosmicPulse.xl),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: CosmicPulse.primary, width: 2),
                shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brXl),
                padding: const EdgeInsets.symmetric(vertical: 16),
                foregroundColor: CosmicPulse.primary,
              ),
              child: Text(
                'Download Lecture PDF',
                style: SupernovaText.labelMd(CosmicPulse.primary).copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextUpCard extends StatelessWidget {
  const _NextUpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CosmicPulse.md),
      decoration: BoxDecoration(
        color: CosmicPulse.primaryFixed.withOpacity(0.5),
        borderRadius: CosmicPulse.brLg,
        border: Border.all(color: const Color(0xFFE0E7FF)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: CosmicPulse.brMd,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Icon(Symbols.quiz, color: CosmicPulse.primary),
          ),
          const SizedBox(width: CosmicPulse.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NEXT UP', style: SupernovaText.labelSm(CosmicPulse.primaryFixedDim)),
                const SizedBox(height: 2),
                Text(
                  'Module Quiz: Wave Mechanics',
                  style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AskAITutorButton extends StatelessWidget {
  const _AskAITutorButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: CosmicPulse.primaryContainer,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: CosmicPulse.primary.withOpacity(0.3),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Symbols.smart_toy, color: Colors.white, size: 22),
              const SizedBox(width: CosmicPulse.sm + 2),
              Text('Ask AI Tutor', style: SupernovaText.labelMd(Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
