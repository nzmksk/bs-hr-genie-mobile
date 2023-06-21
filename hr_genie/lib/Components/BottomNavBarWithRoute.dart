import 'package:flutter/cupertino.dart';

class BottomNavigationBarRoute extends BottomNavigationBarItem {
  final String initialLocation;

  BottomNavigationBarRoute(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}
