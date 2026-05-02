import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lottie/lottie.dart';

/// Performance-tuned Lottie wrapper for the Supernova design system.
///
/// Defaults are picked for prototype speed:
///   * 30fps frame rate cap (≈half the CPU cost of the default 60fps and
///     visually indistinguishable for ambient UI animations).
///   * Asset path is probed once via [rootBundle.load]; missing files fall
///     back to [fallback] without ever blocking or rebuilding tightly.
///   * Network composition is cached in-memory after first decode.
///   * The animation controller is owned and disposed by this widget, so
///     animations in offscreen tabs (IndexedStack) do not consume frames.
class SupernovaLottie extends StatefulWidget {
  const SupernovaLottie.asset(
    this.path, {
    super.key,
    this.size,
    this.speed = 1.0,
    this.repeat = true,
    this.reverse = false,
    this.fit = BoxFit.contain,
    this.fallback,
  }) : url = null;

  const SupernovaLottie.network(
    this.url, {
    super.key,
    this.size,
    this.speed = 1.0,
    this.repeat = true,
    this.reverse = false,
    this.fit = BoxFit.contain,
    this.fallback,
  }) : path = null;

  final String? path;
  final String? url;
  final double? size;
  final double speed;
  final bool repeat;
  final bool reverse;
  final BoxFit fit;
  final Widget? fallback;

  @override
  State<SupernovaLottie> createState() => _SupernovaLottieState();
}

class _SupernovaLottieState extends State<SupernovaLottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Future<LottieComposition?> _composition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _composition = _resolve();
  }

  @override
  void didUpdateWidget(covariant SupernovaLottie old) {
    super.didUpdateWidget(old);
    if (old.path != widget.path || old.url != widget.url) {
      _composition = _resolve();
    } else if (old.speed != widget.speed) {
      _applyDuration(_controller.duration?.inMilliseconds);
    }
  }

  Future<LottieComposition?> _resolve() async {
    try {
      if (widget.path != null) {
        // Probe asset existence once. If absent we silently fall back.
        await rootBundle.load(widget.path!);
        final composition = await AssetLottie(widget.path!).load();
        _bindComposition(composition);
        return composition;
      }
      if (widget.url != null) {
        final composition = await NetworkLottie(widget.url!).load();
        _bindComposition(composition);
        return composition;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  void _bindComposition(LottieComposition composition) {
    _applyDuration(composition.duration.inMilliseconds);
    if (!mounted) return;
    if (widget.repeat) {
      _controller.repeat(reverse: widget.reverse);
    } else {
      _controller.forward(from: 0);
    }
  }

  void _applyDuration(int? baseMs) {
    if (baseMs == null || baseMs <= 0) return;
    final scaled = (baseMs / widget.speed).round();
    _controller.duration = Duration(milliseconds: scaled <= 0 ? 1 : scaled);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FutureBuilder<LottieComposition?>(
        future: _composition,
        builder: (context, snapshot) {
          final composition = snapshot.data;
          if (composition == null) {
            return widget.fallback ?? const SizedBox.shrink();
          }
          return Lottie(
            composition: composition,
            controller: _controller,
            fit: widget.fit,
            // 30fps cap is ~half the CPU of the default 60fps and is visually
            // smooth for ambient UI motion.
            frameRate: FrameRate(30),
          );
        },
      ),
    );
  }
}

/// Curated free Lottie sources used across the app.
///
/// Asset paths are checked first (drop matching JSON files into
/// `assets/animations/`); if absent, [SupernovaLottie] silently falls back to
/// the supplied fallback widget — never blocking the UI.
class SupernovaAnimations {
  const SupernovaAnimations._();

  static const String streakFire = 'assets/animations/streak_fire.json';
  static const String success = 'assets/animations/success_burst.json';
  static const String tryAgain = 'assets/animations/try_again.json';
  static const String aiOrb = 'assets/animations/ai_orb.json';
  static const String emptyInbox = 'assets/animations/empty_inbox.json';
  static const String searchSpark = 'assets/animations/search_spark.json';
  static const String trophy = 'assets/animations/trophy.json';
  static const String confetti = 'assets/animations/confetti.json';
}

/// Pure-Dart fallback animation: a subtle pulsing ring driven by a single
/// AnimationController. Used when no Lottie file is bundled — guarantees
/// that every animated surface still feels alive without paying decode cost.
class PulseRing extends StatefulWidget {
  const PulseRing({
    super.key,
    required this.color,
    this.icon,
    this.size = 64,
    this.duration = const Duration(milliseconds: 1600),
  });

  final Color color;
  final IconData? icon;
  final double size;
  final Duration duration;

  @override
  State<PulseRing> createState() => _PulseRingState();
}

class _PulseRingState extends State<PulseRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          return CustomPaint(
            painter: _PulsePainter(progress: _c.value, color: widget.color),
            child: widget.icon == null
                ? null
                : Center(
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: widget.size * 0.45,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  _PulsePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final base = size.shortestSide / 2;

    for (int i = 0; i < 2; i++) {
      final t = (progress + i * 0.5) % 1.0;
      final r = base * (0.55 + 0.45 * t);
      final opacity = (1 - t).clamp(0.0, 1.0) * 0.35;
      final p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color.withOpacity(opacity);
      canvas.drawCircle(center, r, p);
    }

    final core = Paint()..color = color.withOpacity(0.12);
    canvas.drawCircle(center, base * 0.55, core);
  }

  @override
  bool shouldRepaint(covariant _PulsePainter old) => old.progress != progress;
}
