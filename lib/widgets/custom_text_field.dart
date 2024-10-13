// lib/widgets/custom_text_field.dart

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField({
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
