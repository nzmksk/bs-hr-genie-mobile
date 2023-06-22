import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 400,
          height: 650,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.key,
                  size: 170,
                ),
                CustomTextField(
                    hintText: "New Password",
                    icon: const Icon(Icons.password),
                    onchanged: (value) {},
                    errorStyle: null,
                    errorText: null),
                CustomTextField(
                    hintText: "Repeat Password",
                    icon: const Icon(Icons.password),
                    onchanged: (value) {},
                    errorStyle: null,
                    errorText: null),
                SubmitButton(
                    label: "Update",
                    margin: const EdgeInsets.fromLTRB(0, 180, 0, 40),
                    onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
