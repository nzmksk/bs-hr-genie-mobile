import 'package:flutter/cupertino.dart';

class SummaryTextDisplay extends StatelessWidget {
  final String? value;
  const SummaryTextDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        ': ${value ?? ""}',
        textAlign: TextAlign.left,
      ),
    );
  }
}
