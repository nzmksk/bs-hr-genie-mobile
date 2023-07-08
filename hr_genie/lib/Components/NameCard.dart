import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';
import 'package:hr_genie/Constants/Color.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: 400,
      height: 200,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: cardColor,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: primaryBlue,
                  child: Text("M"),
                  radius: 30,
                ),
                title: Text(
                  "Mark Wien",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Senior Manager,Food Management",
                  style: TextStyle(fontSize: 16, color: subtitleTextColor),
                ),
              ),
              Divider(
                color: globalTextColor,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountLeaveComponent(
                    title: 'Available',
                    count: 2,
                    countColor: globalTextColor,
                  ),
                  CountLeaveComponent(
                    title: 'Total',
                    count: 26,
                    countColor: globalTextColor,
                  ),
                  CountLeaveComponent(
                    title: 'Used',
                    count: 22,
                    countColor: Colors.red,
                  )
                ],
              )
            ],
          )),
    );
  }
}
