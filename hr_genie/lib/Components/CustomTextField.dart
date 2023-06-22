import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final TextStyle? errorStyle;
  final String? errorText;
  final Function(String) onchanged;
  final Iterable<String>? autofillHints;
  final bool autoFocus;
  final IconButton? suffixIcon;
  final bool enabled;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.autofillHints,
    this.focusNode,
    this.controller,
    required this.hintText,
    required this.onchanged,
    required this.errorStyle,
    required this.errorText,
    this.suffixIcon,
    this.obscureText = false,
    this.autoFocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        enabled: enabled,
        autofillHints: autofillHints,
        autofocus: autoFocus,
        onChanged: onchanged,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorStyle: errorStyle,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextStyle? errorStyle;
  final String? errorText;
  final Function() onpress;
  final Function(String) onchanged;
  final String hintText;
  final bool autoFocus;
  const PasswordField({
    super.key,
    required bool obscurePassword,
    required this.onpress,
    required this.onchanged,
    required this.hintText,
    this.errorStyle,
    this.errorText,
    this.autoFocus = false,
  }) : _obscurePassword = obscurePassword;

  final bool _obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        autofillHints: const [AutofillHints.password],
        autofocus: autoFocus,
        onChanged: onchanged,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
            errorStyle: errorStyle,
            errorText: errorText,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
                onPressed: onpress,
                icon: Icon(_obscurePassword
                    ? Icons.visibility
                    : Icons.visibility_off)),
            // border: OutlineInputBorder(),
            hintText: hintText),
      ),
    );
  }
}
