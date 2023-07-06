import 'package:flutter/material.dart';
import 'package:hr_genie/Constants/Color.dart';

class RequestCountCard extends StatelessWidget {
  const RequestCountCard({super.key, this.onTap});
  final TextStyle numberStyle = const TextStyle(fontSize: 30);
  final TextStyle redCount = const TextStyle(fontSize: 30, color: Colors.red);
  final TextStyle titleStyle = const TextStyle(fontSize: 15);
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // padding: const EdgeInsets.all(8),
      width: 400,
      height: 100,
      child: InkWell(
        customBorder:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RequestIndicator(
                titleStyle: titleStyle,
                numberStyle: numberStyle,
                count: '10',
                title: 'Total',
              ),
              RequestIndicator(
                titleStyle: titleStyle,
                numberStyle: numberStyle,
                count: '2',
                title: 'Approved',
              ),
              RequestIndicator(
                titleStyle: titleStyle,
                numberStyle: numberStyle,
                count: '1',
                title: 'Rejected',
              ),
              RequestIndicator(
                titleStyle: titleStyle,
                numberStyle: redCount,
                count: '7',
                title: 'Pending',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestIndicator extends StatelessWidget {
  const RequestIndicator({
    super.key,
    required this.titleStyle,
    required this.numberStyle,
    required this.title,
    required this.count,
  });

  final TextStyle titleStyle;
  final TextStyle numberStyle;
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          count,
          style: numberStyle,
        )
      ],
    );
  }
}
