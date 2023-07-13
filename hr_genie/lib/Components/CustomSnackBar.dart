import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, Color color) {
  final snackBar = SnackBar(
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
