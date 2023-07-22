import 'package:flutter/material.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  final String nextPageLocation;
  final String message;
  const SuccessDialog(
      {super.key, required this.nextPageLocation, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Padding(
          // color: Colors.red,
          padding: const EdgeInsets.all(10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/success.json',
                animate: true,
                repeat: false,
              ),
              Text(message),
              SubmitButton(
                  margin: const EdgeInsets.all(10),
                  label: 'OK',
                  onPressed: () {
                    AppRouter.router.go(nextPageLocation);
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
