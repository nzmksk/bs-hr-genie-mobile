import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
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
  const EmailField({
    super.key,
    this.prefixIcon,
    this.autofillHints,
    this.focusNode,
    this.controller,
    required this.hintText,
    required this.onchanged,
    this.errorStyle,
    this.errorText,
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
        // focusNode: focusNode,
        obscureText: obscureText,
        autofillHints: const [AutofillHints.email],
        autofocus: autoFocus,
        onChanged: onchanged,
        enabled: enabled,
        decoration: InputDecoration(
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
  final bool enabled;
  final bool _obscurePassword;
  final TextEditingController? controller;
  const PasswordField({
    super.key,
    required bool obscurePassword,
    required this.onpress,
    required this.onchanged,
    required this.hintText,
    this.controller,
    this.errorStyle,
    this.errorText,
    this.enabled = true,
    this.autoFocus = false,
  }) : _obscurePassword = obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: controller,
        autofillHints: const [AutofillHints.password],
        autofocus: autoFocus,
        onChanged: onchanged,
        enabled: enabled,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          errorStyle: errorStyle,
          errorText: errorText,
          hintText: hintText,
          prefixIcon: const Icon(Icons.password),
          suffixIcon: IconButton(
              onPressed: onpress,
              icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off)),
        ),
      ),
    );
  }
}

class NewPasswordField extends StatefulWidget {
  final String hintText;
  final Icon? prefixIcon;
  final TextStyle? errorStyle;
  final String? errorText;
  final Function(String) onchanged;
  final Iterable<String>? autofillHints;
  final bool autoFocus;
  final IconButton? suffixIcon;
  final bool enabled;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const NewPasswordField({
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
    this.autoFocus = false,
    this.enabled = true,
  });

  @override
  State<NewPasswordField> createState() => _NewPasswordFieldState();
}

class _NewPasswordFieldState extends State<NewPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: obscureText,
        enabled: widget.enabled,
        autofillHints: widget.autofillHints,
        autofocus: widget.autoFocus,
        onChanged: widget.onchanged,
        decoration: InputDecoration(
            fillColor: Colors.white,
            errorStyle: widget.errorStyle,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off)),
            hintText: widget.hintText),
      ),
    );
  }
}

class RepeatPasswordField extends StatelessWidget {
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
  const RepeatPasswordField({
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
