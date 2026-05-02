import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/cosmic_pulse_theme.dart';
import '../widgets/auth_hero.dart';
import '../widgets/glass_card.dart';
import 'home_shell.dart';
import 'otp_verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String _grade = 'Grade 11';
  bool _googleLoading = false;
  bool _otpLoading = false;

  static const _grades = <String>[
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12',
  ];

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  bool get _formValid =>
      _name.text.trim().length >= 2 && _phone.text.trim().length == 10;

  Future<void> _continueWithGoogle() async {
    setState(() => _googleLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
      (_) => false,
    );
  }

  Future<void> _createAccount() async {
    if (!_formValid) return;
    setState(() => _otpLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _otpLoading = false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          phone: _phone.text.trim(),
          newAccountName: _name.text.trim(),
        ),
      ),
    );
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
      body: SingleChildScrollView(
        child: AuthEnterAnimation(
          child: Column(
            children: [
              const AuthHero(
                eyebrow: 'Create your account',
                title: 'Start your supernova',
                subtitle:
                    'Personalised learning paths, AI tutoring, and streaks that actually stick.',
                heroSize: 96,
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
                        'YOUR DETAILS',
                        style: SupernovaText.labelMd(CosmicPulse.primary),
                      ),
                      const SizedBox(height: CosmicPulse.md),
                      _LabeledField(
                        icon: Symbols.person,
                        hint: 'Full name',
                        controller: _name,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: CosmicPulse.md),
                      _PhoneField(
                        controller: _phone,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: CosmicPulse.md),
                      _GradePicker(
                        value: _grade,
                        options: _grades,
                        onChanged: (v) => setState(() => _grade = v),
                      ),
                      const SizedBox(height: CosmicPulse.lg),
                      _LoadingPrimaryButton(
                        label: 'Create Account',
                        icon: Symbols.arrow_forward,
                        loading: _otpLoading,
                        enabled: _formValid,
                        onPressed: _createAccount,
                      ),
                      const SizedBox(height: CosmicPulse.lg),
                      const _OrDivider(),
                      const SizedBox(height: CosmicPulse.lg),
                      _GoogleButton(
                        loading: _googleLoading,
                        onPressed: _continueWithGoogle,
                      ),
                      const SizedBox(height: CosmicPulse.md),
                      _SignInLink(
                        onTap: () => Navigator.of(context).maybePop(),
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

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

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
          Icon(icon, color: CosmicPulse.primary),
          const SizedBox(width: CosmicPulse.sm),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: CosmicPulse.primary,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              style: SupernovaText.bodyMd(CosmicPulse.onSurface),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: hint,
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

class _GradePicker extends StatelessWidget {
  const _GradePicker({
    required this.value,
    required this.options,
    required this.onChanged,
  });
  final String value;
  final List<String> options;
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
          const Icon(Symbols.school, color: CosmicPulse.primary),
          const SizedBox(width: CosmicPulse.sm),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Symbols.expand_more,
                    color: CosmicPulse.onSurfaceVariant),
                dropdownColor: CosmicPulse.surfaceContainerLowest,
                style: SupernovaText.bodyMd(CosmicPulse.onSurface),
                items: [
                  for (final o in options)
                    DropdownMenuItem(
                      value: o,
                      child: Text(o,
                          style: SupernovaText.bodyMd(CosmicPulse.onSurface)),
                    ),
                ],
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
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
                    'SIGN UP WITH GOOGLE',
                    style: SupernovaText.labelMd(CosmicPulse.primary),
                  ),
                ],
              ),
      ),
    );
  }
}

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
    canvas.drawArc(r, -1.5708, 1.5708, false, paint..color = _red);
    canvas.drawArc(r, 0, 1.5708, false, paint..color = _yellow);
    canvas.drawArc(r, 1.5708, 1.5708, false, paint..color = _green);
    canvas.drawArc(r, 3.1416, 1.5708, false, paint..color = _blue);
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

class _SignInLink extends StatelessWidget {
  const _SignInLink({required this.onTap});
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
                  text: 'Already a learner?  ',
                  style: SupernovaText.bodyMd(CosmicPulse.onSurfaceVariant),
                ),
                TextSpan(
                  text: 'Sign in',
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
