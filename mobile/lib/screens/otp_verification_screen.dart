import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/auth_hero.dart';
import '../widgets/glass_card.dart';
import '../widgets/otp_input.dart';
import '../widgets/supernova_lottie.dart';
import 'home_shell.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.phone,
    this.newAccountName,
  });

  final String phone;
  final String? newAccountName;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const _resendSeconds = 30;

  String _otp = '';
  bool _verifying = false;
  bool _showSuccess = false;
  int _secondsLeft = _resendSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsLeft = _resendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft -= 1;
        } else {
          t.cancel();
        }
      });
    });
  }

  Future<void> _verify() async {
    if (_otp.length < 6 || _verifying) return;
    setState(() => _verifying = true);
    // Stub for prototype — replace with actual OTP verification.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _verifying = false;
      _showSuccess = true;
    });
    // Brief celebratory pause before pushing into the app shell.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
      (_) => false,
    );
  }

  String get _maskedPhone {
    final p = widget.phone;
    if (p.length < 4) return p;
    final last = p.substring(p.length - 4);
    return '+91 ••••• $last';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Row(
            children: [
              const SizedBox(width: CosmicPulse.sm),
              IconButton(
                icon: const Icon(Symbols.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AuthEnterAnimation(
              child: Column(
                children: [
                  AuthHero(
                    eyebrow: widget.newAccountName == null
                        ? 'Verify it\'s you'
                        : 'Welcome, ${widget.newAccountName}',
                    title: 'Enter the 6-digit code',
                    subtitle: 'We sent it to $_maskedPhone',
                    heroSize: 88,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      CosmicPulse.md,
                      CosmicPulse.lg,
                      CosmicPulse.md,
                      CosmicPulse.xl,
                    ),
                    child: GlassCard(
                      borderRadius: CosmicPulse.brXxl,
                      padding: const EdgeInsets.all(CosmicPulse.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'ONE-TIME PASSWORD',
                            style: SupernovaText.labelMd(CosmicPulse.primary),
                          ),
                          const SizedBox(height: CosmicPulse.md),
                          OtpInput(
                            onChanged: (v) => setState(() => _otp = v),
                            onCompleted: (_) => _verify(),
                          ),
                          const SizedBox(height: CosmicPulse.lg),
                          _ResendRow(
                            secondsLeft: _secondsLeft,
                            onResend: () {
                              _startTimer();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: CosmicPulse.primary,
                                  content: Text(
                                    'A fresh code is on its way.',
                                    style: SupernovaText.labelMd(Colors.white)
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: CosmicPulse.lg),
                          _VerifyButton(
                            loading: _verifying,
                            enabled: _otp.length == 6,
                            onPressed: _verify,
                          ),
                          const SizedBox(height: CosmicPulse.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Symbols.shield,
                                size: 16,
                                color: CosmicPulse.tertiary,
                              ),
                              const SizedBox(width: CosmicPulse.xs),
                              Text(
                                'Encrypted end-to-end',
                                style: SupernovaText.labelSm(
                                    CosmicPulse.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showSuccess)
            Positioned.fill(
              child: _SuccessOverlay(),
            ),
        ],
      ),
    );
  }
}

class _ResendRow extends StatelessWidget {
  const _ResendRow({required this.secondsLeft, required this.onResend});
  final int secondsLeft;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final canResend = secondsLeft <= 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          canResend
              ? "Didn't get the code?"
              : 'Resend code in ${secondsLeft}s',
          style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
        ),
        const SizedBox(width: CosmicPulse.xs + 2),
        if (canResend)
          InkWell(
            onTap: onResend,
            borderRadius: CosmicPulse.brMd,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              child: Text(
                'Resend',
                style: SupernovaText.labelMd(CosmicPulse.primary),
              ),
            ),
          ),
      ],
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton({
    required this.loading,
    required this.enabled,
    required this.onPressed,
  });

  final bool loading;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1 : 0.5,
      duration: const Duration(milliseconds: 180),
      child: IgnorePointer(
        ignoring: !enabled || loading,
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: CosmicPulse.brLg,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: CosmicPulse.supernovaGradient,
                  borderRadius: CosmicPulse.brLg,
                  boxShadow: CosmicPulse.primaryGlow(blur: 16, opacity: 0.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: loading
                      ? const [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ]
                      : [
                          Text(
                            'VERIFY & CONTINUE',
                            style: SupernovaText.labelMd(Colors.white),
                          ),
                          const SizedBox(width: CosmicPulse.sm),
                          const Icon(
                            Symbols.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CosmicPulse.background.withOpacity(0.92),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SupernovaLottie.asset(
            SupernovaAnimations.success,
            size: 160,
            repeat: false,
            fallback: PulseRing(
              color: CosmicPulse.tertiary,
              icon: Symbols.check,
              size: 120,
            ),
          ),
          const SizedBox(height: CosmicPulse.md),
          Text(
            'Verified!',
            style: SupernovaText.headlineLg(CosmicPulse.primary),
          ),
          const SizedBox(height: CosmicPulse.xs),
          Text(
            'Lighting up your dashboard…',
            style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
