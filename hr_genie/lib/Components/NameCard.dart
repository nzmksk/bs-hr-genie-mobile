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
              Padding(
                padding: EdgeInsets.all(0.8),
                child: ListTile(
                  // tileColor: Colors.grey[600],
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://t4.ftcdn.net/jpg/05/62/99/31/360_F_562993122_e7pGkeY8yMfXJcRmclsoIjtOoVDDgIlh.jpg'),
                  ),
                  title: Text(
                    "Mark Wien",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Senior Manager,Food Management",
                    style: TextStyle(fontSize: 12, color: subtitleTextColor),
                  ),
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
