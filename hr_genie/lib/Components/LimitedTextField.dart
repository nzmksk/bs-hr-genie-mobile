import 'package:flutter/material.dart';

class LimitedTextField extends StatefulWidget {
  final int maxLength;

  const LimitedTextField({Key? key, this.maxLength = 255}) : super(key: key);

  @override
  _LimitedTextFieldState createState() => _LimitedTextFieldState();
}

class _LimitedTextFieldState extends State<LimitedTextField> {
  TextEditingController _controller = TextEditingController();
  int _remainingChars = 255;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateRemainingChars);
  }

  void _updateRemainingChars() {
    setState(() {
      _remainingChars = widget.maxLength - _controller.text.length;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: true,
      controller: _controller,
      maxLength: widget.maxLength,
      maxLines: null, // Allow multiline input
      decoration: InputDecoration(
        counterText: '$_remainingChars/${widget.maxLength}',
        hintText: "Reason",
      ),
    );
  }
}
