import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_genie/Constants/Color.dart';

class MyLeaveEmpty extends StatelessWidget {
  const MyLeaveEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "You apply nothing..",
            style: TextStyle(fontSize: 30, color: subtitleTextColor),
          ),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/apply.svg',
            width: 170,
            height: 170,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Apply for leave just at your finger tips!",
            style: TextStyle(color: instructionTextColor),
          )
        ],
      ),
    );
  }
}
