import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';

class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({
    super.key,
    required this.progress,
    this.height = 12,
    this.backgroundColor,
    this.gradient,
    this.glowColor,
  });

  final double progress;
  final double height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? CosmicPulse.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: LayoutBuilder(
        builder: (_, c) {
          final w = c.maxWidth * progress.clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: w,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient ?? CosmicPulse.supernovaGradient,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: (glowColor ?? CosmicPulse.primary).withOpacity(0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
