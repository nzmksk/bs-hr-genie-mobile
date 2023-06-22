import 'package:flutter/material.dart';

class TextStyleStore {
  TextStyle success() {
    return const TextStyle(color: Colors.green);
  }

  TextStyle failed() {
    return const TextStyle(color: Colors.red);
  }
}
