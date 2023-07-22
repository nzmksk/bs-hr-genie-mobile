import 'package:flutter/material.dart';
import 'package:hr_genie/Components/ShimmerLeaveApplication.dart';
import 'package:hr_genie/Components/ShimmerLeaveDetailsPage.dart';
import 'package:hr_genie/Components/ShimmerRequestDetailPage.dart';
import 'package:hr_genie/Components/ShimmerRequestPage.dart';

import 'ShimmerLeavePage.dart';

class ShimmerLoading extends StatelessWidget {
  final String screenName;
  const ShimmerLoading({
    super.key,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return loadByRouteName(screenName);
  }
}

Widget loadByRouteName(String screenName) {
  switch (screenName) {
    case "LEAVE":
      return const ShimmerLeavePage();
    case "LEAVE FORM":
      return const ShimmerLeaveApplication();
    case "LEAVE DETAILS":
      return const ShimmerLeaveDetailsPage();
    case "REQUEST":
      return const ShimmerRequest();
    case "REQUEST DETAILS":
      return const ShimmerRequestDetailsPage();
    default:
      return const CircularProgressIndicator();
  }
}
