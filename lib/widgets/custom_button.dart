// lib/widgets/custom_button.dart

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? borderRadius;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.padding,
    this.fontSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        onPrimary: textColor ?? Colors.white,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
