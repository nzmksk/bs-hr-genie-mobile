import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Consider as not found"),
          ElevatedButton.icon(
            onPressed: () {
              AppRouter.router.go("/");
            },
            icon: const Icon(Icons.navigation),
            label: const Text("Reset"),
          )
        ],
      )),
    );
  }
}
