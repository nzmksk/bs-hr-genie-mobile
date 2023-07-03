import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? trailing;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const CustomListTile(
      {super.key,
      this.title,
      this.trailing,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: color,
      margin: margin,
      child: InkWell(
        onTap: onTap,
        customBorder:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: color,
            title: title,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
