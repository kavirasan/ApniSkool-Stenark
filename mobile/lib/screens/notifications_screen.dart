import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_app_bar.dart';
import '../widgets/supernova_lottie.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _items = <_NotificationData>[
    _NotificationData(
      icon: Symbols.local_fire_department,
      iconColor: CosmicPulse.secondary,
      iconBg: Color(0x1AB90538),
      title: 'Streak protected!',
      body: 'You hit your daily goal — 14 day streak unlocked.',
      time: '2m ago',
      pulse: true,
    ),
    _NotificationData(
      icon: Symbols.smart_toy,
      iconColor: CosmicPulse.primary,
      iconBg: Color(0x1A4648D4),
      title: 'Nova has a new tip for you',
      body: 'Diffraction patterns explained with the photo-shutter analogy.',
      time: '1h ago',
    ),
    _NotificationData(
      icon: Symbols.event_available,
      iconColor: CosmicPulse.tertiary,
      iconBg: Color(0x1A006C49),
      title: 'Live class @ 4 PM',
      body: 'Dr. Sarah Thompson — Advanced Thermodynamics.',
      time: '3h ago',
    ),
    _NotificationData(
      icon: Symbols.workspace_premium,
      iconColor: CosmicPulse.primary,
      iconBg: Color(0x1A4648D4),
      title: 'Top 5% this week',
      body: 'You ranked above 95% of Grade 11 Science peers.',
      time: 'Yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SupernovaAppBar(
        title: 'Notifications',
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Today',
                  style: SupernovaText.headlineLg(CosmicPulse.onSurface),
                ),
              ),
              Text(
                'Mark all read',
                style: SupernovaText.labelMd(CosmicPulse.primary),
              ),
            ],
          ),
          const SizedBox(height: CosmicPulse.md),
          for (final n in _items) ...[
            _NotificationTile(data: n),
            const SizedBox(height: CosmicPulse.sm + 4),
          ],
          const SizedBox(height: CosmicPulse.xl),
          _EmptyHint(),
        ],
      ),
    );
  }
}

class _NotificationData {
  const _NotificationData({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.body,
    required this.time,
    this.pulse = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String body;
  final String time;
  final bool pulse;
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.data});
  final _NotificationData data;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(CosmicPulse.md),
      borderRadius: CosmicPulse.brLg,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: data.pulse
                ? PulseRing(color: data.iconColor, icon: data.icon, size: 48)
                : Container(
                    decoration: BoxDecoration(
                      color: data.iconBg,
                      borderRadius: CosmicPulse.brMd,
                    ),
                    alignment: Alignment.center,
                    child: Icon(data.icon, color: data.iconColor, size: 24),
                  ),
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
                        data.title,
                        style: SupernovaText.bodyMd(CosmicPulse.onSurface)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      data.time,
                      style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  data.body,
                  style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SupernovaLottie.asset(
          SupernovaAnimations.emptyInbox,
          size: 140,
          speed: 0.9,
          fallback: PulseRing(
            color: CosmicPulse.primary,
            icon: Symbols.mark_email_read,
            size: 96,
          ),
        ),
        const SizedBox(height: CosmicPulse.md),
        Text(
          "You're all caught up!",
          style: SupernovaText.headlineMd(CosmicPulse.onSurface),
        ),
        const SizedBox(height: CosmicPulse.xs),
        Text(
          'Older notifications fade after 7 days.',
          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
