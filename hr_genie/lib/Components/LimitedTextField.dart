import 'package:flutter/material.dart';

class LimitedTextField extends StatefulWidget {
  final int maxLength;
  final Function(String) onchanged;
  final TextEditingController controller;
  final FocusNode? focus;

  LimitedTextField(
      {Key? key,
      this.maxLength = 255,
      required this.onchanged,
      required this.controller,
      this.focus})
      : super(key: key);

  @override
  _LimitedTextFieldState createState() => _LimitedTextFieldState();
}

class _LimitedTextFieldState extends State<LimitedTextField> {
  int _remainingChars = 255;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateRemainingChars);
  }

  void _updateRemainingChars() {
    setState(() {
      _remainingChars = widget.maxLength - widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focus,
      autofocus: true,
      onChanged: widget.onchanged,
      expands: true,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: null, // Allow multiline input
      decoration: InputDecoration(
        counterText: '$_remainingChars/${widget.maxLength}',
        hintText: "Reason",
      ),
    );
  }
}
