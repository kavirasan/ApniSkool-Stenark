import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/auth_hero.dart';
import '../widgets/glass_card.dart';
import '../widgets/supernova_buttons.dart';
import 'home_shell.dart';
import 'otp_verification_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phone = TextEditingController();
  bool _googleLoading = false;
  bool _otpLoading = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  bool get _phoneValid => _phone.text.trim().length == 10;

  Future<void> _continueWithGoogle() async {
    setState(() => _googleLoading = true);
    // Stub for prototype — replace with real Google sign-in.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeShell()),
    );
  }

  Future<void> _sendOtp() async {
    if (!_phoneValid) return;
    setState(() => _otpLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _otpLoading = false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(phone: _phone.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicPulse.background,
      body: SingleChildScrollView(
        child: AuthEnterAnimation(
          child: Column(
            children: [
              const AuthHero(
                eyebrow: 'Kalvi Supernova',
                title: 'Welcome back',
                subtitle: 'Pick up your streak right where you left off.',
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
                        'CONTINUE WITH MOBILE',
                        style: SupernovaText.labelMd(CosmicPulse.primary),
                      ),
                      const SizedBox(height: CosmicPulse.sm),
                      _PhoneField(controller: _phone, onChanged: (_) => setState(() {})),
                      const SizedBox(height: CosmicPulse.md),
                      _LoadingPrimaryButton(
                        label: 'Send OTP',
                        icon: Symbols.arrow_forward,
                        loading: _otpLoading,
                        enabled: _phoneValid,
                        onPressed: _sendOtp,
                      ),
                      const SizedBox(height: CosmicPulse.lg),
                      const _OrDivider(),
                      const SizedBox(height: CosmicPulse.lg),
                      _GoogleButton(
                        loading: _googleLoading,
                        onPressed: _continueWithGoogle,
                      ),
                      const SizedBox(height: CosmicPulse.lg),
                      _SignUpLink(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CosmicPulse.surfaceContainerLow,
        borderRadius: CosmicPulse.brLg,
        border: Border.all(color: CosmicPulse.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: CosmicPulse.md),
      child: Row(
        children: [
          const Icon(Symbols.phone_iphone, color: CosmicPulse.primary),
          const SizedBox(width: CosmicPulse.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: CosmicPulse.primaryFixed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+91',
              style: SupernovaText.labelMd(CosmicPulse.onPrimaryFixed),
            ),
          ),
          const SizedBox(width: CosmicPulse.sm),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              cursorColor: CosmicPulse.primary,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: SupernovaText.bodyMd(CosmicPulse.onSurface)
                  .copyWith(letterSpacing: 1.2),
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: '98765 43210',
                hintStyle: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingPrimaryButton extends StatelessWidget {
  const _LoadingPrimaryButton({
    required this.label,
    required this.loading,
    required this.enabled,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final bool loading;
  final bool enabled;
  final VoidCallback onPressed;
  final IconData? icon;

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
                      ? [
                          const SizedBox(
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
                            label.toUpperCase(),
                            style: SupernovaText.labelMd(Colors.white),
                          ),
                          if (icon != null) ...[
                            const SizedBox(width: CosmicPulse.sm),
                            Icon(icon, color: Colors.white, size: 18),
                          ],
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

class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: CosmicPulse.md),
          child: Text(
            'OR',
            style: SupernovaText.labelMd(CosmicPulse.onSurfaceVariant),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.loading, required this.onPressed});
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: CosmicPulse.primary, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: CosmicPulse.brLg),
          padding: const EdgeInsets.symmetric(vertical: 14),
          foregroundColor: CosmicPulse.primary,
        ),
        child: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: CosmicPulse.primary,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _GoogleGlyph(size: 20),
                  const SizedBox(width: CosmicPulse.sm + 2),
                  Text(
                    'CONTINUE WITH GOOGLE',
                    style: SupernovaText.labelMd(CosmicPulse.primary),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Compact 4-arc Google "G" rendered as a CustomPaint so we don't ship an
/// extra image asset. Tuned to feel on-brand without being a literal logo.
class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph({required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _green = Color(0xFF34A853);
  static const _yellow = Color(0xFFFBBC05);
  static const _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = size.shortestSide * 0.18;
    final inset = stroke / 2;
    final r = rect.deflate(inset);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = stroke;

    // Four quarter arcs in the four Google brand colors.
    canvas.drawArc(r, -1.5708, 1.5708, false, paint..color = _red);
    canvas.drawArc(r, 0, 1.5708, false, paint..color = _yellow);
    canvas.drawArc(r, 1.5708, 1.5708, false, paint..color = _green);
    canvas.drawArc(r, 3.1416, 1.5708, false, paint..color = _blue);

    // The classic right-facing tail of the "G".
    final tail = Paint()..color = _blue;
    final tailRect = Rect.fromLTWH(
      size.width * 0.5,
      size.height * 0.42,
      size.width * 0.42,
      size.height * 0.16,
    );
    canvas.drawRect(tailRect, tail);
  }

  @override
  bool shouldRepaint(covariant _GooglePainter old) => false;
}

class _SignUpLink extends StatelessWidget {
  const _SignUpLink({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: CosmicPulse.brMd,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CosmicPulse.sm,
            vertical: 6,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'New to Kalvi Supernova?  ',
                  style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                ),
                TextSpan(
                  text: 'Sign up',
                  style: SupernovaText.labelMd(CosmicPulse.primary)
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
