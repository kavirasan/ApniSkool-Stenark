import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/cosmic_pulse_theme.dart';

/// 6-cell OTP entry that auto-advances on input and auto-retreats on
/// backspace. Emits the full code via [onCompleted] once all 6 digits are
/// present, and [onChanged] whenever the value mutates.
class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _value => _controllers.map((c) => c.text).join();

  void _onChange(int index, String v) {
    if (v.length > 1) {
      // Handle paste-style input — distribute across cells.
      final digits = v.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = i < digits.length ? digits[i] : '';
      }
      final next = digits.length.clamp(0, widget.length - 1);
      _focusNodes[next].requestFocus();
    } else if (v.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (v.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final value = _value;
    widget.onChanged?.call(value);
    if (value.length == widget.length && !value.contains(' ')) {
      widget.onCompleted?.call(value);
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) => _buildCell(i)),
    );
  }

  Widget _buildCell(int i) {
    final focus = _focusNodes[i];
    return AnimatedBuilder(
      animation: focus,
      builder: (_, __) {
        final hasValue = _controllers[i].text.isNotEmpty;
        final active = focus.hasFocus || hasValue;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          width: 48,
          height: 56,
          decoration: BoxDecoration(
            color: active ? Colors.white : CosmicPulse.surfaceContainerLow,
            borderRadius: CosmicPulse.brLg,
            border: Border.all(
              color: focus.hasFocus
                  ? CosmicPulse.primary
                  : (hasValue ? CosmicPulse.primaryFixedDim : CosmicPulse.outlineVariant),
              width: focus.hasFocus ? 2 : 1.5,
            ),
            boxShadow: focus.hasFocus
                ? [
                    BoxShadow(
                      color: CosmicPulse.primary.withOpacity(0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _controllers[i],
            focusNode: focus,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: i == 0 ? widget.length : 1,
            cursorColor: CosmicPulse.primary,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: SupernovaText.headlineMd(CosmicPulse.onSurface),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (v) => _onChange(i, v),
          ),
        );
      },
    );
  }
}
