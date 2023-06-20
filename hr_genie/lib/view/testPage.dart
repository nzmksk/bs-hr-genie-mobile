import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/routes/app_routes.dart';
import 'package:hr_genie/routes/routes_utils.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton.icon(
      onPressed: () {
        AppRouter.router.go(PAGES.leave.screenPath);
      },
      icon: const Icon(Icons.navigate_next),
      label: const Text("Go to home"),
    )));
  }
}
