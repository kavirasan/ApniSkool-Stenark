import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(CosmicPulse.lg),
    this.borderRadius = CosmicPulse.brXl,
    this.opacity = 0.7,
    this.showShadow = true,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double opacity;
  final bool showShadow;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: showShadow ? CosmicPulse.ambientShadow() : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: borderRadius,
              border: Border.all(
                color: borderColor ?? const Color(0x80E2E8F0),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
