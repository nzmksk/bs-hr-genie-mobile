import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Color.dart';

class ShimmerRequest extends StatelessWidget {
  const ShimmerRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            width: double.infinity,
            color: cardColor,
          )),
      body: Shimmer.fromColors(
        direction: ShimmerDirection.ttb,
        baseColor: Colors.white24,
        highlightColor: Colors.grey,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ShimmerListTile(),
            ShimmerListTile(),
            ShimmerListTile(),
            ShimmerListTile(),
            ShimmerListTile(),
            ShimmerListTile(),
          ],
        ),
      ),
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
      ),
      title: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
        height: 15,
        // width: 10,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      subtitle: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 200, 0),
        height: 10,
        // width: 5,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
