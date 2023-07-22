import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

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
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        style: const TextStyle(color: globalTextColor),
        controller: controller,
        // focusNode: focusNode,
        obscureText: obscureText,
        autofillHints: const [AutofillHints.email],
        autofocus: autoFocus,
        onChanged: onchanged,
        enabled: enabled,
        decoration: CustomInputDeco(),
      ),
    );
  }

  InputDecoration CustomInputDeco() {
    return InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorBorderColor),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: errorBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryLightBlue),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryBlue)),
        hintStyle: const TextStyle(color: secondaryLightBlue),
        focusColor: primaryBlue,
        prefixIconColor: primaryLightBlue,
        suffixIconColor: primaryLightBlue,
        fillColor: globalTextColor,
        errorStyle: errorStyle,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText);
  }
}

class PasswordField extends StatelessWidget {
  final TextStyle? errorStyle;
  final String? errorText;
  final Function() onpress;
  final String hintText;
  final bool _obscurePassword;
  final Function(String) onchanged;
  final bool autoFocus;
  final bool enabled;
  final TextEditingController? controller;
  final bool? visibleToggle;
  const PasswordField({
    this.visibleToggle = true,
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
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: disabledButtonColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: errorBorderColor),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryLightBlue),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryBlue)),
          hintStyle: const TextStyle(color: secondaryLightBlue),
          errorStyle: errorStyle,
          errorText: errorText,
          hintText: hintText,
          prefixIcon: const Icon(
            Icons.lock,
            color: primaryLightBlue,
          ),
          suffixIcon: visibleToggle!
              ? IconButton(
                  onPressed: onpress,
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: primaryLightBlue,
                  ),
                )
              : null,
          fillColor: globalTextColor,
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
  final Function() onpress;
  final bool _obscurePassword;

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
    required this.onpress,
    required bool obscurePassword,
  }) : _obscurePassword = obscurePassword;

  @override
  State<NewPasswordField> createState() => _NewPasswordFieldState();
}

class _NewPasswordFieldState extends State<NewPasswordField> {
  final bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: _obscurePassword,
        enabled: widget.enabled,
        autofillHints: widget.autofillHints,
        autofocus: widget.autoFocus,
        onChanged: widget.onchanged,
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: disabledButtonColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: errorBorderColor),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryLightBlue),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryBlue)),
          hintStyle: const TextStyle(color: secondaryLightBlue),
          errorStyle: widget.errorStyle,
          errorText: widget.errorText,
          hintText: widget.hintText,
          prefixIcon: const Icon(
            Icons.password,
            color: primaryLightBlue,
          ),
          suffixIcon: IconButton(
            onPressed: widget.onpress,
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: primaryLightBlue,
            ),
          ),
          fillColor: globalTextColor,
        ),
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
