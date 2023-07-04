import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon? icon;
  final TextStyle? errorStyle;
  final String? errorText;
  final Function(String) onchanged;
  final Iterable<String>? autofillHints;

  final IconButton? suffixIcon;
  const CustomTextField({
    super.key,
    this.icon,
    this.autofillHints,
    required this.hintText,
    required this.onchanged,
    required this.errorStyle,
    required this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        autofillHints: autofillHints,
        autofocus: true,
        onChanged: onchanged,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorStyle: errorStyle,
            errorText: errorText,
            prefixIcon: icon,
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
  const PasswordField({
    super.key,
    required bool obscurePassword,
    required this.onpress,
    required this.onchanged,
    required this.hintText,
    this.errorStyle,
    this.errorText,
  }) : _obscurePassword = obscurePassword;

  final bool _obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        autofillHints: const [AutofillHints.password],
        autofocus: true,
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
