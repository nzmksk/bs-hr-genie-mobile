import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class CancelAppButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;

  const CancelAppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.margin,
    this.width = 300,
    this.height = 46,
    this.buttonColor,
    this.textColor,
  });

  @override
  State<CancelAppButton> createState() => _CancelAppButtonState();
}

class _CancelAppButtonState extends State<CancelAppButton> {
  int time = 5;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (time != 0) {
          time--;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time.toString(),
            style: const TextStyle(fontSize: 100),
          ),
          const Text(
            'This approved leave will be revoked',
            style: TextStyle(color: subtitleTextColor, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledForegroundColor: primaryBlack,
                disabledBackgroundColor: primaryLightBlue,
                backgroundColor: widget.buttonColor ?? primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: widget.onPressed,
              child: SizedBox(
                width: 200,
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: widget.textColor),
                ),
              )),
        ],
      ),
    );
  }
}
