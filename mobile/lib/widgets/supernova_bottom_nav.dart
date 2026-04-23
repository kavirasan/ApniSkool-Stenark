import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';

class SupernovaBottomNav extends StatelessWidget {
  const SupernovaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const _items = <_NavItem>[
    _NavItem('Dashboard', Symbols.dashboard),
    _NavItem('Curriculum', Symbols.menu_book),
    _NavItem('AI Tutor', Symbols.smart_toy),
    _NavItem('Tests', Symbols.quiz),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            border: const Border(
              top: BorderSide(color: Color(0x80E2E8F0)),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -4),
                blurRadius: 24,
                color: const Color(0xFF6366F1).withOpacity(0.1),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: CosmicPulse.sm + 4,
            left: CosmicPulse.md,
            right: CosmicPulse.md,
            bottom: MediaQuery.of(context).padding.bottom + CosmicPulse.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final active = i == currentIndex;
              return _NavTile(
                label: item.label,
                icon: item.icon,
                active: active,
                onTap: () => onChanged(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? CosmicPulse.primary : const Color(0xFF94A3B8);
    return InkWell(
      onTap: onTap,
      borderRadius: CosmicPulse.brXl,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: CosmicPulse.brXl,
          color: active ? const Color(0xFFE0E7FF) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              fill: active ? 1 : 0,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: SupernovaText.labelSm(color).copyWith(
                fontSize: 10,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
