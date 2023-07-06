import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;

  const SubmitButton({
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
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disabledButtonColor,
            backgroundColor: buttonColor ?? primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(color: textColor),
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