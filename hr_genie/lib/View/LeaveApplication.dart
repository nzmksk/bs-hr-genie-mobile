import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/LeaveAppForm.dart';

class LeaveApplicationPage extends StatelessWidget {
  const LeaveApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              title: 'New Application',
            )),
        resizeToAvoidBottomInset: false,
        body: LeaveAppForm(),
      ),
    );
  }
}
