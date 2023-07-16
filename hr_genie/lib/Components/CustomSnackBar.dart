import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String content, Color color) {
  final snackBar = SnackBar(
    // margin: const EdgeInsets.fromLTRB(20, 0, 20, 660),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    content: Text(content),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
