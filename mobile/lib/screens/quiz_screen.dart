import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_buttons.dart';

class QuizQuestion {
  const QuizQuestion({required this.prompt, required this.options, required this.answerIndex});
  final String prompt;
  final List<String> options;
  final int answerIndex;
}

const _sampleQuestions = <QuizQuestion>[
  QuizQuestion(
    prompt:
        'According to the Heisenberg Uncertainty Principle, what is the fundamental limit to what we can know about a particle?',
    options: [
      'The exact mass and volume of a particle at any given moment.',
      'The simultaneous position and momentum of a particle.',
      "The speed of light relative to the particle's observer.",
      'The precise time a particle will undergo radioactive decay.',
    ],
    answerIndex: 1,
  ),
  QuizQuestion(
    prompt: 'Which experiment most clearly demonstrates wave-particle duality?',
    options: [
      "Millikan's oil drop experiment.",
      "Rutherford's gold foil experiment.",
      "The double-slit experiment with single electrons.",
      "Young's classical prism experiment.",
    ],
    answerIndex: 2,
  ),
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int? _selected;
  bool _favorite = false;
  bool _showAiTip = true;

  QuizQuestion get _q => _sampleQuestions[_current % _sampleQuestions.length];

  void _next() {
    setState(() {
      _current += 1;
      _selected = null;
      _favorite = false;
      _showAiTip = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SupernovaAppBar(
        trailing: [
          SupernovaIconAction(icon: Symbols.notifications, onTap: () {}),
          SupernovaIconAction(icon: Symbols.close, onTap: () => Navigator.of(context).maybePop()),
        ],
      ),
      body: Stack(
        children: [
          // Decorative blobs
          Positioned(
            top: -80,
            right: -80,
            child: _blob(color: CosmicPulse.primary.withOpacity(0.05), size: 240),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: _blob(color: CosmicPulse.tertiary.withOpacity(0.05), size: 200),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(
              CosmicPulse.md,
              CosmicPulse.md,
              CosmicPulse.md,
              CosmicPulse.xl + CosmicPulse.md,
            ),
            children: [
              _QuizHeader(current: _current, total: 15),
              const SizedBox(height: CosmicPulse.lg),
              _QuestionCard(
                question: _q,
                favorite: _favorite,
                selected: _selected,
                onFavoriteToggle: () => setState(() => _favorite = !_favorite),
                onSelect: (i) => setState(() => _selected = i),
              ),
              const SizedBox(height: CosmicPulse.md),
              if (_showAiTip)
                _AiTipCard(onDismiss: () => setState(() => _showAiTip = false)),
              const SizedBox(height: CosmicPulse.xl),
              _ActionBar(onNext: _next),
              const SizedBox(height: CosmicPulse.xl),
              _paginationDots(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _blob({required Color color, required double size}) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  Widget _paginationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: CosmicPulse.outlineVariant,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizHeader extends StatelessWidget {
  const _QuizHeader({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final displayCurrent = ((current % total) + 1).toString().padLeft(2, '0');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: CosmicPulse.primaryFixed,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Physics • Quantum Basics',
                      style: SupernovaText.labelMd(CosmicPulse.primary),
                    ),
                  ),
                  const SizedBox(height: CosmicPulse.sm),
                  Text('Topic Mastery Quiz',
                      style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: displayCurrent,
                    style: SupernovaText.headlineMd(CosmicPulse.primary),
                  ),
                  TextSpan(
                    text: ' / $total',
                    style: SupernovaText.labelMd(CosmicPulse.outline),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: CosmicPulse.md),
        GradientProgressBar(
          progress: ((current % total) + 1) / total,
          height: 12,
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.favorite,
    required this.selected,
    required this.onFavoriteToggle,
    required this.onSelect,
  });

  final QuizQuestion question;
  final bool favorite;
  final int? selected;
  final VoidCallback onFavoriteToggle;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brXxl,
      padding: const EdgeInsets.all(CosmicPulse.lg + CosmicPulse.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(question.prompt,
                    style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: onFavoriteToggle,
                    icon: Icon(
                      Symbols.star,
                      fill: favorite ? 1 : 0,
                      color: favorite ? CosmicPulse.secondary : CosmicPulse.outline,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Symbols.volume_up, color: CosmicPulse.primary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          for (int i = 0; i < question.options.length; i++) ...[
            _OptionTile(
              letter: String.fromCharCode('A'.codeUnitAt(0) + i),
              text: question.options[i],
              selected: selected == i,
              onTap: () => onSelect(i),
            ),
            if (i != question.options.length - 1) const SizedBox(height: CosmicPulse.md - 4),
          ],
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: CosmicPulse.brXl,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(CosmicPulse.md + 4),
              decoration: BoxDecoration(
                gradient: selected ? CosmicPulse.supernovaGradient : null,
                color: selected ? null : Colors.white,
                borderRadius: CosmicPulse.brXl,
                border: Border.all(
                  color: selected ? CosmicPulse.primary : CosmicPulse.outlineVariant,
                  width: 2,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: CosmicPulse.primary.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withOpacity(0.2)
                          : CosmicPulse.surfaceContainer,
                      borderRadius: CosmicPulse.brMd,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: SupernovaText.labelMd(
                        selected ? Colors.white : CosmicPulse.primary,
                      ).copyWith(fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: CosmicPulse.md),
                  Expanded(
                    child: Text(
                      text,
                      style: SupernovaText.bodyLg(
                        selected ? Colors.white : CosmicPulse.onSurface,
                      ).copyWith(fontSize: 16),
                    ),
                  ),
                  if (selected) const Icon(Symbols.check_circle, color: Colors.white, fill: 1),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Symbols.volume_up, color: selected ? CosmicPulse.primary : CosmicPulse.outline),
        ),
      ],
    );
  }
}

class _AiTipCard extends StatelessWidget {
  const _AiTipCard({required this.onDismiss});
  final VoidCallback onDismiss;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: CosmicPulse.tertiary.withOpacity(0.1),
                    borderRadius: CosmicPulse.brLg,
                  ),
                  child: const Icon(Symbols.smart_toy, color: CosmicPulse.tertiary, fill: 1),
                ),
                const SizedBox(width: CosmicPulse.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'AI TUTOR TIP • EASY UNDERSTAND',
                              style: SupernovaText.labelMd(CosmicPulse.tertiary),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'SMART HELP',
                              style: SupernovaText.labelSm(const Color(0xFF047857))
                                  .copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: CosmicPulse.sm),
                      RichText(
                        text: TextSpan(
                          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                          children: const [
                            TextSpan(
                              text:
                                  'Imagine trying to take a photo of a moving car. If you use a fast shutter, you see the ',
                            ),
                            TextSpan(
                              text: 'position',
                              style: TextStyle(
                                color: CosmicPulse.tertiary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' clearly but not the speed. If you use a slow shutter, you see the ',
                            ),
                            TextSpan(
                              text: 'momentum (blur)',
                              style: TextStyle(
                                color: CosmicPulse.tertiary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " but not the exact position. You can't have both perfectly!",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CosmicPulse.md),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: CosmicPulse.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onDismiss,
                  icon: const Icon(Symbols.thumb_up, size: 18),
                  label: const Text('Helpful'),
                  style: TextButton.styleFrom(foregroundColor: CosmicPulse.outline),
                ),
                const SizedBox(width: CosmicPulse.sm),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Symbols.lightbulb, size: 18),
                  label: const Text('Deep Dive'),
                  style: TextButton.styleFrom(foregroundColor: CosmicPulse.outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SupernovaOutlinedButton(label: 'Save for Later', onPressed: () {}),
        SupernovaPrimaryButton(
          label: 'Next Question',
          onPressed: onNext,
          icon: Symbols.arrow_forward,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ],
    );
  }
}
