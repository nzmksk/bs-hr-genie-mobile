import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const CustomListTile(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      this.padding,
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
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: padding,
            // isThreeLine: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: leading,
            tileColor: color,
            title: title,
            subtitle: subtitle,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
