import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';

class SupernovaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SupernovaAppBar({
    super.key,
    this.title = 'Kalvi Supernova',
    this.trailing = const [_NotificationsAction()],
  });

  static const double _contentHeight = 64;

  final String title;
  final List<Widget> trailing;

  static double _statusBarHeight() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.padding.top / view.devicePixelRatio;
  }

  @override
  Size get preferredSize => Size.fromHeight(_contentHeight + _statusBarHeight());

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: _contentHeight + topPadding,
          padding: EdgeInsets.only(
            top: topPadding,
            left: CosmicPulse.md,
            right: CosmicPulse.md,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: const Border(
              bottom: BorderSide(color: Color(0x80E2E8F0)),
            ),
            boxShadow: CosmicPulse.ambientShadow(),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: CosmicPulse.supernovaGradient,
                  border: Border.all(
                    color: CosmicPulse.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: const Icon(Symbols.person, color: Colors.white, size: 22),
              ),
              const SizedBox(width: CosmicPulse.sm + 4),
              Text(
                title,
                style: SupernovaText.headlineMd(CosmicPulse.primary).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              ...trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationsAction extends StatelessWidget {
  const _NotificationsAction();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Symbols.notifications, color: CosmicPulse.onSurfaceVariant),
      style: IconButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
      ),
    );
  }
}

class SupernovaIconAction extends StatelessWidget {
  const SupernovaIconAction({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: CosmicPulse.onSurfaceVariant),
      style: IconButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
      ),
    );
  }
}
