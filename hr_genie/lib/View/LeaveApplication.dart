import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/LeaveAppForm.dart';

class LeaveApplicationPage extends StatelessWidget {
  const LeaveApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: LeaveAppForm(),
        ),
      ),
    );
  }
}
