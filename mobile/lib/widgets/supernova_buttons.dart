import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';

class SupernovaPrimaryButton extends StatelessWidget {
  const SupernovaPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = false,
    this.padding = const EdgeInsets.symmetric(horizontal: CosmicPulse.md + 4, vertical: CosmicPulse.sm + 4),
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: SupernovaText.labelMd(Colors.white),
        ),
        if (icon != null) ...[
          const SizedBox(width: CosmicPulse.sm),
          Icon(icon, color: Colors.white, size: 18),
        ],
      ],
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: CosmicPulse.brLg,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: CosmicPulse.supernovaGradient,
            borderRadius: CosmicPulse.brLg,
            boxShadow: CosmicPulse.primaryGlow(blur: 16, opacity: 0.25),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SupernovaOutlinedButton extends StatelessWidget {
  const SupernovaOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: CosmicPulse.primary, width: 2),
        shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
        padding: const EdgeInsets.symmetric(
          horizontal: CosmicPulse.md + 4,
          vertical: CosmicPulse.sm + 4,
        ),
        foregroundColor: CosmicPulse.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: CosmicPulse.sm),
          ],
          Text(
            label.toUpperCase(),
            style: SupernovaText.labelMd(CosmicPulse.primary),
          ),
        ],
      ),
    );
  }
}

class SupernovaChip extends StatelessWidget {
  const SupernovaChip({
    super.key,
    required this.label,
    this.background,
    this.foreground,
  });

  final String label;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final bg = background ?? CosmicPulse.primary.withOpacity(0.1);
    final fg = foreground ?? CosmicPulse.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: SupernovaText.labelMd(fg).copyWith(fontSize: 11),
      ),
    );
  }
}
