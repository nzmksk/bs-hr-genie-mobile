import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Color.dart';

class ShimmerRequestDetailsPage extends StatelessWidget {
  const ShimmerRequestDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: "Leave Review")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShimmerDetails(label: "Employee Name"),
            ShimmerDetails(label: "Leave Type"),
            ShimmerDetails(label: "Date"),
            ShimmerDetails(label: "Duration"),
            ShimmerDetails(label: "Reason"),
            ShimmerDetails(label: "Attachment"),
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: SubmitButton(label: "Reject", onPressed: null)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: SubmitButton(label: "Approve", onPressed: null)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerDetails extends StatelessWidget {
  final String label;
  const ShimmerDetails({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: Colors.white24,
          highlightColor: Colors.grey,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(label),
          ),
        ),
        Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: Colors.white24,
          highlightColor: Colors.grey,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: cardColor),
          ),
        ),
      ],
    );
  }
}
