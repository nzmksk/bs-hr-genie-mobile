import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class LeaveTileInfo extends StatelessWidget {
  final String label;
  final String? value;
  final Color? color;
  const LeaveTileInfo(
      {super.key,
      required this.label,
      required this.value,
      this.color = cardColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: const EdgeInsets.only(top: 10), child: Text(label))),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          width: double.maxFinite,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Text(value ?? ""),
        ),
      ],
    );
  }
}
