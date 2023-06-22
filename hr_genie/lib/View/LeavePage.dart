import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/LeaveTabs.dart';
import 'package:hr_genie/Components/NameCard.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          ProfileCard(),
          LeaveTabs(),
          // LeaveTab(),
        ],
      ),
    );
  }
}
