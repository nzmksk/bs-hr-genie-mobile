import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lost_connection.json',
              height: 170,
              width: 170,
            ),
            const Text(
              "Lost connection..",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      )),
    );
  }
}
