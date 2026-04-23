import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cosmic_pulse_theme.dart';

class ProgressOrb extends StatelessWidget {
  const ProgressOrb({
    super.key,
    required this.progress,
    required this.label,
    required this.color,
    this.size = 96,
  });

  /// 0.0 to 1.0
  final double progress;
  final String label;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _OrbPainter(progress: progress, color: color),
            child: Center(
              child: Text(
                '${(progress * 100).round()}%',
                style: SupernovaText.headlineMd(color),
              ),
            ),
          ),
        ),
        const SizedBox(height: CosmicPulse.sm),
        Text(
          label,
          style: SupernovaText.labelMd(CosmicPulse.onSurface),
        ),
      ],
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide / 2) - 6;
    final stroke = 8.0;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = CosmicPulse.surfaceContainerHighest;
    canvas.drawCircle(center, radius, bg);

    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, glow);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, fg);
  }

  @override
  bool shouldRepaint(covariant _OrbPainter old) =>
      old.progress != progress || old.color != color;
}
