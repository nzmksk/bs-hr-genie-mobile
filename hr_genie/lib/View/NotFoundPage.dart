import 'package:flutter/material.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found page"),
      ),
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
