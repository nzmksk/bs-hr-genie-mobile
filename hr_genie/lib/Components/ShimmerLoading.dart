import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/ShimmerLeaveApplication.dart';

import 'ShimmerLeavePage.dart';

class ShimmerLoading extends StatelessWidget {
  final String screenName;
  const ShimmerLoading({
    super.key,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return getWidgetBasedOnCondition(screenName);
  }
}

Widget getWidgetBasedOnCondition(String screenName) {
  switch (screenName) {
    case "LEAVE":
      return const ShimmerLeavePage();
    case "LEAVE FORM":
      return const ShimmerLeaveApplication();

    default:
      return const CircularProgressIndicator();
  }
}
