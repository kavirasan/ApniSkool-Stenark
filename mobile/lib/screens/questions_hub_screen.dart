import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import 'quiz_screen.dart';

class QuestionsHubScreen extends StatelessWidget {
  const QuestionsHubScreen({super.key});

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
        Text('Important Questions Hub', style: SupernovaText.headlineXl(CosmicPulse.onSurface)),
        const SizedBox(height: CosmicPulse.sm),
        Text(
          'Your command center for high-yield academic mastery. Focus on what truly matters with our curated supernova-intensity question bank.',
          style: SupernovaText.bodyLg(CosmicPulse.onSurfaceVariant),
        ),
        const SizedBox(height: CosmicPulse.xl),

        _DailyChallengeCard(
          onStart: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const QuizScreen()),
          ),
        ),
        const SizedBox(height: CosmicPulse.md),
        const _ActiveStreakCard(),
        const SizedBox(height: CosmicPulse.xl),

        _SectionHeader(
          title: 'Top Important Questions',
          trailing: Text('View All', style: SupernovaText.labelMd(CosmicPulse.primary)),
        ),
        const SizedBox(height: CosmicPulse.md),
        const _QuestionListItem(
          number: 'Q1',
          subject: 'Advanced Macroeconomics',
          body: 'Analysis of fiscal multipliers in emerging markets...',
          starred: true,
        ),
        const SizedBox(height: CosmicPulse.sm + 4),
        const _QuestionListItem(
          number: 'Q2',
          subject: 'Neurobiology',
          body: 'Synthesizing synaptic plasticity in hippocampal circuits...',
        ),
        const SizedBox(height: CosmicPulse.sm + 4),
        const _QuestionListItem(
          number: 'Q3',
          subject: 'Abstract Algebra',
          body: 'Proof of Isomorphism Theorems in Group Theory...',
          starred: true,
        ),

        const SizedBox(height: CosmicPulse.xl),
        _SectionHeader(
          title: 'Most Repeated Questions',
          trailing: Text('Top Questions',
              style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant).copyWith(
                fontStyle: FontStyle.italic,
              )),
        ),
        const SizedBox(height: CosmicPulse.md),
        const _RepeatedItem(
          count: '15 TIMES',
          subject: 'Quantum Physics',
          body: "Heisenberg's Uncertainty Principle Derivation",
        ),
        const SizedBox(height: CosmicPulse.sm + 4),
        const _RepeatedItem(
          count: '12 TIMES',
          subject: 'Constitutional Law',
          body: 'Judicial Review and Separation of Powers',
          starred: true,
        ),

        const SizedBox(height: CosmicPulse.xl),
        Text('Curated Question Sets', style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
        const SizedBox(height: CosmicPulse.md),
        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _CuratedSetCard(
                title: 'Elite Calculus',
                questionCount: '24 Questions',
                curator: 'Curated by Prof. Miller',
                iconA: Symbols.functions,
                iconB: Symbols.pi,
                colorA: Color(0xFF6366F1),
                colorB: Color(0xFF8B5CF6),
              ),
              SizedBox(width: CosmicPulse.md),
              _CuratedSetCard(
                title: 'Organic Synthesis',
                questionCount: '42 Questions',
                curator: 'Curated by Supernova AI',
                iconA: Symbols.science,
                iconB: Symbols.biotech,
                colorA: Color(0xFF10B981),
                colorB: Color(0xFF06B6D4),
                starred: true,
              ),
              SizedBox(width: CosmicPulse.md),
              _CuratedSetCard(
                title: 'Modern Conflicts',
                questionCount: '18 Questions',
                curator: 'Global Scholars Dept',
                iconA: Symbols.history_edu,
                iconB: Symbols.public,
                colorA: Color(0xFFF59E0B),
                colorB: Color(0xFFEF4444),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CosmicPulse.brLg,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(CosmicPulse.lg),
            decoration: BoxDecoration(
              color: CosmicPulse.primaryContainer,
              borderRadius: CosmicPulse.brLg,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('Daily Challenges', style: SupernovaText.labelMd(Colors.white)),
                ),
                const SizedBox(height: CosmicPulse.md),
                Text("Conquer Today's Blitz", style: SupernovaText.headlineLg(Colors.white)),
                const SizedBox(height: CosmicPulse.sm),
                Text(
                  'Complete 5 high-priority questions in Quantitative Reasoning to maintain your streak.',
                  style: SupernovaText.bodyMd(Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: CosmicPulse.md),
                ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: CosmicPulse.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
                  ),
                  child: Text('Start Now', style: SupernovaText.labelMd(CosmicPulse.primary)),
                ),
              ],
            ),
          ),
          Positioned(
            top: -20,
            right: -20,
            child: Opacity(
              opacity: 0.15,
              child: Icon(Symbols.bolt, size: 160, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveStreakCard extends StatelessWidget {
  const _ActiveStreakCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Active Streak', style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Text('12 Days', style: SupernovaText.headlineMd(CosmicPulse.primary)),
                  ],
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: CosmicPulse.secondaryFixed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Symbols.local_fire_department,
                    color: CosmicPulse.secondary, fill: 1),
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily Goal', style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
              Text('80%', style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: CosmicPulse.xs),
          const GradientProgressBar(progress: 0.8, height: 8),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing});

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Text(title, style: SupernovaText.headlineMd(CosmicPulse.onSurface))),
        trailing,
      ],
    );
  }
}

class _QuestionListItem extends StatelessWidget {
  const _QuestionListItem({
    required this.number,
    required this.subject,
    required this.body,
    this.starred = false,
  });

  final String number;
  final String subject;
  final String body;
  final bool starred;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: CosmicPulse.brLg,
      padding: const EdgeInsets.all(CosmicPulse.md),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: CosmicPulse.surfaceContainerHigh,
              borderRadius: CosmicPulse.brMd,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: SupernovaText.labelMd(CosmicPulse.primary).copyWith(fontSize: 15),
            ),
          ),
          const SizedBox(width: CosmicPulse.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: SupernovaText.labelMd(CosmicPulse.tertiaryContainer)),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: SupernovaText.bodyMd(CosmicPulse.onSurface)
                      .copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Symbols.star,
            fill: starred ? 1 : 0,
            color: starred ? CosmicPulse.secondaryContainer : const Color(0xFFCBD5E1),
          ),
        ],
      ),
    );
  }
}

class _RepeatedItem extends StatelessWidget {
  const _RepeatedItem({
    required this.count,
    required this.subject,
    required this.body,
    this.starred = false,
  });

  final String count;
  final String subject;
  final String body;
  final bool starred;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CosmicPulse.md),
      decoration: BoxDecoration(
        color: CosmicPulse.surfaceContainer,
        borderRadius: CosmicPulse.brLg,
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          const Icon(Symbols.repeat, color: CosmicPulse.secondary),
          const SizedBox(width: CosmicPulse.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: CosmicPulse.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        count,
                        style: SupernovaText.labelSm(CosmicPulse.secondary).copyWith(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: CosmicPulse.sm),
                    Text(subject, style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: SupernovaText.bodyMd(CosmicPulse.onSurface)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Icon(
            Symbols.star,
            fill: starred ? 1 : 0,
            color: starred ? CosmicPulse.secondaryContainer : const Color(0xFFCBD5E1),
          ),
        ],
      ),
    );
  }
}

class _CuratedSetCard extends StatelessWidget {
  const _CuratedSetCard({
    required this.title,
    required this.questionCount,
    required this.curator,
    required this.iconA,
    required this.iconB,
    required this.colorA,
    required this.colorB,
    this.starred = false,
  });

  final String title;
  final String questionCount;
  final String curator;
  final IconData iconA;
  final IconData iconB;
  final Color colorA;
  final Color colorB;
  final bool starred;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: CosmicPulse.brXl,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorA, colorB],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Opacity(
                      opacity: 0.25,
                      child: Icon(iconA, color: Colors.white, size: 80),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 16,
                    child: Opacity(
                      opacity: 0.4,
                      child: Icon(iconB, color: Colors.white, size: 60),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    left: CosmicPulse.md,
                    bottom: CosmicPulse.md,
                    right: CosmicPulse.md,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questionCount,
                          style: SupernovaText.labelSm(Colors.white.withOpacity(0.85)),
                        ),
                        Text(title, style: SupernovaText.headlineMd(Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: CosmicPulse.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  curator,
                  style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Symbols.star,
                fill: starred ? 1 : 0,
                color: starred ? CosmicPulse.secondaryContainer : const Color(0xFFCBD5E1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
