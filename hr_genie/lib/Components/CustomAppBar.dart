import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showLogo;
  const CustomAppBar({super.key, required this.title, this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: cardColor,
      title: showLogo
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 50,
                    width: 50,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          : Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
    );
  }
}
