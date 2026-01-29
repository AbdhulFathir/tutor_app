import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_styling.dart';

import '../../../core/theme/theme_data.dart';

class OTPField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final bool autoFocus;
  final double fieldSize;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final Color? fillColor;
  final bool hasBorder;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;

  const OTPField({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
    this.autoFocus = true,
    this.fieldSize = 64,
    this.textStyle,
    this.cursorColor,
    this.fillColor,
    this.hasBorder = true,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _initializeControllersAndFocusNodes();
  }

  void _initializeControllersAndFocusNodes() {
    _controllers = List.generate(
      widget.length,
          (index) => TextEditingController(),
    );

    _focusNodes = List.generate(
      widget.length,
          (index) => FocusNode(),
    );
  }

  void _onTextChanged(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _updateOTPCode();

    if (_otpCode.length == widget.length) {
      widget.onCompleted(_otpCode);
    }

    widget.onChanged?.call(_otpCode);
  }

  void _updateOTPCode() {
    setState(() {
      _otpCode = _controllers.map((controller) => controller.text).join();
    });
  }

  // void _pasteCode(String value) {
  //   final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  //
  //   for (int i = 0; i < widget.length && i < cleanValue.length; i++) {
  //     _controllers[i].text = cleanValue[i];
  //   }
  //
  //   _updateOTPCode();
  //
  //   if (_otpCode.length == widget.length) {
  //     widget.onCompleted(_otpCode);
  //   }
  // }
  //
  // void _clearAllFields() {
  //   for (var controller in _controllers) {
  //     controller.clear();
  //   }
  //   _focusNodes[0].requestFocus();
  //   _updateOTPCode();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: List.generate(
        widget.length,
            (index) => SizedBox(
          height: 46.w,
          width:  46.w,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            onChanged: (value) => _onTextChanged(value, index),
            style: widget.textStyle ?? AppStyling.normal600Size16,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            cursorColor: widget.cursorColor ?? theme.primaryColor,
            decoration: InputDecoration(
              counterText: '',
              border: widget.hasBorder ? OutlineInputBorder(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              ) : InputBorder.none,
              enabledBorder: widget.hasBorder ? OutlineInputBorder(
                borderSide: BorderSide(color:  colors(context).text),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              ) : InputBorder.none,
              focusedBorder: widget.hasBorder ? OutlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              ) : InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}