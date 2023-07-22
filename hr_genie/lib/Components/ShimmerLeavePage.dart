import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Color.dart';

class ShimmerLeavePage extends StatelessWidget {
  const ShimmerLeavePage({
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 400,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const ShimmerListTile(),
            const ShimmerListTile(),
            const ShimmerListTile(),
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
