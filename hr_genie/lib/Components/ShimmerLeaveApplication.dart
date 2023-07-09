import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Color.dart';

class ShimmerLeaveApplication extends StatelessWidget {
  const ShimmerLeaveApplication({
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
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.all(10),
              width: 360,
              height: 139,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    // width: 400,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 40,
                          width: 100,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 40,
                          width: 100,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //   width: 400,
            //   height: 48,
            //   decoration: BoxDecoration(
            //     color: Colors.grey,
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            // ),
            // const ShimmerListTile(),
            // const ShimmerListTile(),
            // const ShimmerListTile(),
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
