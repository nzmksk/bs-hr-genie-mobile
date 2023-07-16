import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class TimerButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;

  const TimerButton({
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
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
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
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledForegroundColor: primaryBlack,
            disabledBackgroundColor: primaryLightBlue,
            backgroundColor: widget.buttonColor ?? primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: time == 0 ? widget.onPressed : null,
          child: Text(
            time != 0 ? '$time  ${widget.label}' : widget.label,
            style: TextStyle(color: widget.textColor),
          )),
    );
  }
}

// ButtonStyle(
//             backgroundColor: buttonColor,
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           )