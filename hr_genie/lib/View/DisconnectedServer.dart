import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_genie/Constants/Color.dart';

class DisconnectedServer extends StatelessWidget {
  final String errorMsg;
  const DisconnectedServer({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Disconnected from server..",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: subtitleTextColor),
          ),
          const SizedBox(
            height: 25,
          ),
          SvgPicture.asset(
            'assets/disconnected.svg',
            width: 140,
            height: 140,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Error: $errorMsg",
            style: const TextStyle(color: instructionTextColor),
          )
        ],
      ),
    );
  }
}
