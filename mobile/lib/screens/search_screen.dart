import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  static const _suggestions = <String>[
    'Wave-particle duality',
    'Heisenberg uncertainty',
    'Organic synthesis',
    'Vector algebra',
    'Thermodynamics',
  ];

  static const _trending = <_TrendingTopic>[
    _TrendingTopic(label: 'Quantum mechanics', icon: Symbols.bolt),
    _TrendingTopic(label: 'Carbonyl reactions', icon: Symbols.science),
    _TrendingTopic(label: 'Calculus tricks', icon: Symbols.functions),
    _TrendingTopic(label: 'Live class today', icon: Symbols.live_tv),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _query.trim().isNotEmpty;
    final filtered = hasQuery
        ? _suggestions
            .where((s) => s.toLowerCase().contains(_query.toLowerCase()))
            .toList()
        : _suggestions;

    return Scaffold(
      appBar: SupernovaAppBar(
        title: 'Search',
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
          _SearchField(
            controller: _controller,
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: CosmicPulse.lg),
          if (!hasQuery) ...[
            _Header('Trending now'),
            const SizedBox(height: CosmicPulse.md),
            Wrap(
              spacing: CosmicPulse.sm + 2,
              runSpacing: CosmicPulse.sm + 2,
              children: [
                for (final t in _trending) _TrendingChip(topic: t),
              ],
            ),
            const SizedBox(height: CosmicPulse.xl),
          ],
          _Header(hasQuery ? 'Matches' : 'Suggested for you'),
          const SizedBox(height: CosmicPulse.md),
          if (filtered.isEmpty)
            _EmptyState(query: _query)
          else
            for (final s in filtered) ...[
              _SuggestionTile(label: s, onTap: () {}),
              const SizedBox(height: CosmicPulse.sm),
            ],
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CosmicPulse.surfaceContainerLow,
        borderRadius: CosmicPulse.brLg,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: SupernovaText.bodyMd(CosmicPulse.onSurface),
        cursorColor: CosmicPulse.primary,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: CosmicPulse.md,
            vertical: CosmicPulse.md,
          ),
          hintText: 'Search topics, lectures, questions…',
          hintStyle: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
          prefixIcon: const Icon(Symbols.search, color: CosmicPulse.primary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Symbols.close,
                      color: CosmicPulse.onSurfaceVariant),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
    );
  }
}

class _TrendingTopic {
  const _TrendingTopic({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class _TrendingChip extends StatelessWidget {
  const _TrendingChip({required this.topic});
  final _TrendingTopic topic;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CosmicPulse.md,
          vertical: CosmicPulse.sm + 2,
        ),
        decoration: BoxDecoration(
          color: CosmicPulse.primaryFixed,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(topic.icon, size: 16, color: CosmicPulse.onPrimaryFixed),
            const SizedBox(width: CosmicPulse.xs + 2),
            Text(
              topic.label,
              style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: CosmicPulse.md,
        vertical: CosmicPulse.md - 2,
      ),
      borderRadius: CosmicPulse.brLg,
      child: InkWell(
        onTap: onTap,
        borderRadius: CosmicPulse.brLg,
        child: Row(
          children: [
            const Icon(Symbols.history, color: CosmicPulse.outline),
            const SizedBox(width: CosmicPulse.md),
            Expanded(
              child: Text(
                label,
                style: SupernovaText.bodyMd(CosmicPulse.onSurface)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const Icon(Symbols.north_west, color: CosmicPulse.outlineVariant),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SupernovaLottie.asset(
          SupernovaAnimations.searchSpark,
          size: 160,
          fallback: PulseRing(
            color: CosmicPulse.primary,
            icon: Symbols.search_off,
            size: 96,
          ),
        ),
        const SizedBox(height: CosmicPulse.md),
        Text(
          'No matches for "$query"',
          style: SupernovaText.headlineMd(CosmicPulse.onSurface),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: CosmicPulse.xs),
        Text(
          'Try a different keyword or explore trending topics above.',
          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
