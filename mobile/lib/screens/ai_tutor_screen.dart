import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_lottie.dart';

class AITutorScreen extends StatefulWidget {
  const AITutorScreen({super.key});

  @override
  State<AITutorScreen> createState() => _AITutorScreenState();
}

class _AITutorScreenState extends State<AITutorScreen> {
  final TextEditingController _composer = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final FocusNode _composerFocus = FocusNode();
  final List<_ChatMessage> _messages = <_ChatMessage>[
    _ChatMessage(
      role: _Role.nova,
      text:
          "Hi Arjun! I'm Nova. We left off on Wave-Particle Duality — want me "
          "to walk through it with the photon analogy, or dive into a problem?",
    ),
  ];

  static const _suggestions = <String>[
    'Explain wave-particle duality',
    'Solve a quantum problem',
    'Quiz me on Module 4',
    "Why does Heisenberg's principle matter?",
  ];

  // Canned demo responses — keeps the prototype feeling alive without a real
  // LLM call. Swap with an actual API in the production build.
  static const _replies = <String>[
    'Great question. Picture light as both a wave and a stream of tiny '
        "packets — photons. The double-slit experiment shows both at once: an "
        'interference pattern even when photons are fired one at a time.',
    "Sure — let's break it down. The key constraint is that position and "
        "momentum can't both be measured exactly. Δx · Δp ≥ ℏ/2. Want me to "
        'derive it from a Gaussian wave packet?',
    "Here's a quick problem: a photon has wavelength 500nm. What's its "
        'momentum? Hint: use p = h / λ. Reply with your attempt and I\'ll '
        'check it.',
    "Solid intuition. The trick is that 'observing' a quantum system means "
        'interacting with it — and any interaction perturbs the state. This '
        "isn't a measurement-tool limitation; it's baked into the math.",
  ];

  bool _novaTyping = false;
  Timer? _typingTimer;

  @override
  void dispose() {
    _composer.dispose();
    _scroll.dispose();
    _composerFocus.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  void _send([String? overrideText]) {
    final text = (overrideText ?? _composer.text).trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(role: _Role.user, text: text));
      _composer.clear();
      _novaTyping = true;
    });
    _scrollToBottom();
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final reply = _replies[Random().nextInt(_replies.length)];
      setState(() {
        _novaTyping = false;
        _messages.add(_ChatMessage(role: _Role.nova, text: reply));
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Reserve room for the floating bottom nav so the composer never sits
    // behind it. SupernovaBottomNav clears ~72px + safe-area inset.
    final bottomReserve = MediaQuery.of(context).padding.bottom + 72;
    return Column(
      children: [
        const _NovaHeader(),
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.fromLTRB(
              CosmicPulse.md,
              CosmicPulse.sm,
              CosmicPulse.md,
              CosmicPulse.md,
            ),
            itemCount: _messages.length + (_novaTyping ? 1 : 0),
            itemBuilder: (_, i) {
              if (i == _messages.length && _novaTyping) {
                return const _TypingBubble();
              }
              final m = _messages[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: CosmicPulse.sm + 4),
                child: _MessageBubble(message: m),
              );
            },
          ),
        ),
        _SuggestionStrip(
          suggestions: _suggestions,
          onTap: _send,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: bottomReserve),
          child: _Composer(
            controller: _composer,
            focusNode: _composerFocus,
            onSend: _send,
          ),
        ),
      ],
    );
  }
}

enum _Role { nova, user }

class _ChatMessage {
  const _ChatMessage({required this.role, required this.text});
  final _Role role;
  final String text;
}

class _NovaHeader extends StatelessWidget {
  const _NovaHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CosmicPulse.md,
        CosmicPulse.sm,
        CosmicPulse.md,
        CosmicPulse.sm,
      ),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: CosmicPulse.md,
          vertical: CosmicPulse.sm + 4,
        ),
        borderRadius: CosmicPulse.brXl,
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: SupernovaLottie.asset(
                SupernovaAnimations.aiOrb,
                size: 40,
                fallback: PulseRing(
                  color: CosmicPulse.primary,
                  icon: Symbols.smart_toy,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: CosmicPulse.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nova',
                    style: SupernovaText.headlineMd(CosmicPulse.onSurface)
                        .copyWith(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: CosmicPulse.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Online • AI Tutor',
                        style: SupernovaText.labelSm(CosmicPulse.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CosmicPulse.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: CosmicPulse.primaryFixed,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'BETA',
                style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed)
                    .copyWith(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == _Role.user;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      builder: (_, t, c) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 6),
            child: c,
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const _NovaAvatar(),
            const SizedBox(width: CosmicPulse.sm),
          ],
          Flexible(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: CosmicPulse.md,
                  vertical: CosmicPulse.sm + 4,
                ),
                decoration: BoxDecoration(
                  gradient: isUser ? CosmicPulse.supernovaGradient : null,
                  color: isUser ? null : CosmicPulse.surfaceContainerLowest,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 18),
                  ),
                  border: isUser
                      ? null
                      : Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: isUser
                      ? CosmicPulse.primaryGlow(blur: 12, opacity: 0.18)
                      : CosmicPulse.ambientShadow(blur: 12, opacity: 0.04),
                ),
                child: Text(
                  message.text,
                  style: SupernovaText.bodyMd(
                    isUser ? Colors.white : CosmicPulse.onSurface,
                  ).copyWith(height: 1.45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NovaAvatar extends StatelessWidget {
  const _NovaAvatar();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: SupernovaLottie.asset(
        SupernovaAnimations.aiOrb,
        size: 28,
        fallback: Container(
          decoration: BoxDecoration(
            gradient: CosmicPulse.supernovaGradient,
            shape: BoxShape.circle,
          ),
          child: const Icon(Symbols.auto_awesome,
              color: Colors.white, size: 14),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();
  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CosmicPulse.sm + 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _NovaAvatar(),
          const SizedBox(width: CosmicPulse.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CosmicPulse.md,
              vertical: CosmicPulse.sm + 6,
            ),
            decoration: BoxDecoration(
              color: CosmicPulse.surfaceContainerLowest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: AnimatedBuilder(
              animation: _c,
              builder: (_, __) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final phase = (_c.value + i * 0.18) % 1.0;
                    final lift = (phase < 0.5 ? phase : 1 - phase) * 6;
                    final opacity = 0.4 + (phase < 0.5 ? phase : 1 - phase) * 1.2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Transform.translate(
                        offset: Offset(0, -lift),
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: CosmicPulse.primary
                                .withOpacity(opacity.clamp(0.0, 1.0)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionStrip extends StatelessWidget {
  const _SuggestionStrip({required this.suggestions, required this.onTap});
  final List<String> suggestions;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: CosmicPulse.md),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: CosmicPulse.sm),
        itemBuilder: (_, i) {
          final s = suggestions[i];
          return InkWell(
            onTap: () => onTap(s),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CosmicPulse.md,
                vertical: CosmicPulse.xs + 2,
              ),
              decoration: BoxDecoration(
                color: CosmicPulse.primaryFixed,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: CosmicPulse.primary.withOpacity(0.15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Symbols.auto_awesome,
                      size: 14, color: CosmicPulse.primary),
                  const SizedBox(width: CosmicPulse.xs + 2),
                  Text(
                    s,
                    style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed),
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

class _Composer extends StatefulWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.onSend,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onSend;

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    final has = widget.controller.text.trim().isNotEmpty;
    if (has != _hasText) setState(() => _hasText = has);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CosmicPulse.md,
        CosmicPulse.sm + 4,
        CosmicPulse.md,
        CosmicPulse.sm + 4,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CosmicPulse.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: CosmicPulse.outlineVariant),
          boxShadow: CosmicPulse.ambientShadow(blur: 16, opacity: 0.05),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: CosmicPulse.md - 4,
          vertical: 6,
        ),
        child: Row(
          children: [
            Icon(Symbols.add_circle,
                color: CosmicPulse.primary.withOpacity(0.7)),
            const SizedBox(width: CosmicPulse.xs + 2),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                cursorColor: CosmicPulse.primary,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (v) => widget.onSend(v),
                style: SupernovaText.bodyMd(CosmicPulse.onSurface),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  hintText: 'Ask Nova anything…',
                  hintStyle: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                ),
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 180),
              scale: _hasText ? 1.0 : 0.92,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _hasText ? 1.0 : 0.55,
                child: InkWell(
                  onTap: _hasText ? () => widget.onSend(widget.controller.text) : null,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: CosmicPulse.supernovaGradient,
                      shape: BoxShape.circle,
                      boxShadow: _hasText
                          ? CosmicPulse.primaryGlow(blur: 14, opacity: 0.3)
                          : null,
                    ),
                    child: const Icon(
                      Symbols.send,
                      color: Colors.white,
                      size: 20,
                      fill: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
