import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_progress_bar.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_lottie.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SupernovaAppBar(
        title: 'Profile',
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
        children: const [
          _ProfileHero(),
          SizedBox(height: CosmicPulse.gutter),
          _StatsRow(),
          SizedBox(height: CosmicPulse.gutter),
          _AchievementsCard(),
          SizedBox(height: CosmicPulse.gutter),
          _SettingsCard(),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
            CosmicPulse.lg,
            CosmicPulse.lg + CosmicPulse.md,
            CosmicPulse.lg,
            CosmicPulse.lg,
          ),
          decoration: BoxDecoration(
            gradient: CosmicPulse.supernovaGradient,
            borderRadius: CosmicPulse.brXxl,
            boxShadow: [
              BoxShadow(
                color: CosmicPulse.primary.withOpacity(0.3),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SupernovaLottie.asset(
                SupernovaAnimations.aiOrb,
                size: 120,
                fallback: PulseRing(
                  color: Colors.white,
                  icon: Symbols.person,
                  size: 96,
                ),
              ),
              const SizedBox(height: CosmicPulse.md),
              Text(
                'Arjun Kumar',
                style: SupernovaText.headlineLg(Colors.white),
              ),
              const SizedBox(height: 2),
              Text(
                'Grade 11 • Science Stream',
                style: SupernovaText.bodyMd(Colors.white.withOpacity(0.85)),
              ),
              const SizedBox(height: CosmicPulse.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: CosmicPulse.md,
                  vertical: CosmicPulse.xs + 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Symbols.workspace_premium,
                        color: Colors.white, size: 16, fill: 1),
                    const SizedBox(width: CosmicPulse.xs + 2),
                    Text(
                      'ELITE TIER • LEVEL 12',
                      style: SupernovaText.labelMd(Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CosmicPulse.md),
              const GradientProgressBar(
                progress: 0.62,
                height: 8,
                backgroundColor: Color(0x33FFFFFF),
                gradient: LinearGradient(colors: [Colors.white, Colors.white]),
                glowColor: Colors.white,
              ),
              const SizedBox(height: CosmicPulse.xs),
              Text(
                '620 / 1000 XP to Level 13',
                style: SupernovaText.labelSm(Colors.white.withOpacity(0.85)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatTile(
            icon: Symbols.local_fire_department,
            value: '14',
            label: 'Day streak',
            color: CosmicPulse.secondary,
            pulse: true,
          ),
        ),
        SizedBox(width: CosmicPulse.md),
        Expanded(
          child: _StatTile(
            icon: Symbols.quiz,
            value: '128',
            label: 'Quizzes',
            color: CosmicPulse.primary,
          ),
        ),
        SizedBox(width: CosmicPulse.md),
        Expanded(
          child: _StatTile(
            icon: Symbols.target,
            value: '92%',
            label: 'Accuracy',
            color: CosmicPulse.tertiary,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.pulse = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: CosmicPulse.sm,
        vertical: CosmicPulse.md,
      ),
      borderRadius: CosmicPulse.brLg,
      child: Column(
        children: [
          if (pulse)
            PulseRing(color: color, icon: icon, size: 40)
          else
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: CosmicPulse.brMd,
              ),
              child: Icon(icon, color: color, size: 22, fill: 1),
            ),
          const SizedBox(height: CosmicPulse.sm),
          Text(value, style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
          Text(
            label,
            style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _AchievementsCard extends StatelessWidget {
  const _AchievementsCard();

  @override
  Widget build(BuildContext context) {
    final badges = <_BadgeData>[
      const _BadgeData(
        icon: Symbols.bolt,
        label: 'Lightning',
        color: CosmicPulse.primary,
      ),
      const _BadgeData(
        icon: Symbols.experiment,
        label: 'Lab Pro',
        color: CosmicPulse.tertiary,
      ),
      const _BadgeData(
        icon: Symbols.auto_awesome,
        label: 'Nova Star',
        color: CosmicPulse.secondary,
      ),
      const _BadgeData(
        icon: Symbols.lock,
        label: 'Locked',
        color: CosmicPulse.outline,
        locked: true,
      ),
    ];
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Symbols.emoji_events,
                  color: CosmicPulse.primary, fill: 1),
              const SizedBox(width: CosmicPulse.sm),
              Text('ACHIEVEMENTS',
                  style: SupernovaText.labelMd(CosmicPulse.primary)),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final b in badges)
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: b.locked
                            ? CosmicPulse.surfaceContainerHighest
                            : b.color.withOpacity(0.12),
                        borderRadius: CosmicPulse.brLg,
                      ),
                      child: Icon(b.icon, color: b.color, size: 28, fill: 1),
                    ),
                    const SizedBox(height: CosmicPulse.xs),
                    Text(
                      b.label,
                      style: SupernovaText.labelSm(
                        b.locked
                            ? CosmicPulse.onSurfaceVariant
                            : CosmicPulse.onSurface,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgeData {
  const _BadgeData({
    required this.icon,
    required this.label,
    required this.color,
    this.locked = false,
  });
  final IconData icon;
  final String label;
  final Color color;
  final bool locked;
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard();

  static const _rows = <_SettingRow>[
    _SettingRow(icon: Symbols.notifications, label: 'Notifications'),
    _SettingRow(icon: Symbols.tune, label: 'Learning preferences'),
    _SettingRow(icon: Symbols.shield, label: 'Privacy & data'),
    _SettingRow(icon: Symbols.help, label: 'Help & support'),
    _SettingRow(icon: Symbols.logout, label: 'Sign out', destructive: true),
  ];

  Future<void> _handleSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: CosmicPulse.surfaceContainerLowest,
        shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brXl),
        title: Text('Sign out?',
            style: SupernovaText.headlineMd(CosmicPulse.onSurface)),
        content: Text(
          "We'll keep your streak — sign back in any time to pick up.",
          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Sign out',
                style: SupernovaText.labelMd(CosmicPulse.secondary)),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (int i = 0; i < _rows.length; i++) ...[
            _SettingTile(
              row: _rows[i],
              onTap: _rows[i].destructive
                  ? () => _handleSignOut(context)
                  : null,
            ),
            if (i != _rows.length - 1)
              const Divider(
                height: 1,
                color: Color(0xFFEDEFFA),
                indent: CosmicPulse.lg,
                endIndent: CosmicPulse.lg,
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingRow {
  const _SettingRow({
    required this.icon,
    required this.label,
    this.destructive = false,
  });
  final IconData icon;
  final String label;
  final bool destructive;
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.row, this.onTap});
  final _SettingRow row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = row.destructive ? CosmicPulse.secondary : CosmicPulse.onSurface;
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: CosmicPulse.brXl,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: CosmicPulse.lg,
          vertical: CosmicPulse.md,
        ),
        child: Row(
          children: [
            Icon(row.icon, color: color),
            const SizedBox(width: CosmicPulse.md),
            Expanded(
              child: Text(
                row.label,
                style: SupernovaText.bodyMd(color)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            if (!row.destructive)
              const Icon(Symbols.chevron_right,
                  color: CosmicPulse.outlineVariant),
          ],
        ),
      ),
    );
  }
}
