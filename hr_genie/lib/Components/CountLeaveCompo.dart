import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountLeaveComponent extends StatelessWidget {
  final String title;
  final int? count;
  final Color? countColor;
  const CountLeaveComponent({
    super.key,
    required this.title,
    required this.count,
    this.countColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        children: [
          Text(title),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: RichText(
              text: TextSpan(
                text: "$count",
                style: TextStyle(color: countColor, fontSize: 40),
                children: const [
                  TextSpan(
                      text: " Days",
                      style: TextStyle(fontSize: 15, color: Colors.black87)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
