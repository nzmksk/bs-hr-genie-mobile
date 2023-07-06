import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Controller/Services/LeaveCategory.dart';

class LeaveAppForm extends StatelessWidget {
  const LeaveAppForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("New Application"),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 600,
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Type of leave"),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RadioListTile(
                            title:
                                Text(LEAVES.annual.leaveTypeName.leaveTitle!),
                            value: "male",
                            groupValue: "male",
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RadioListTile(
                            title:
                                Text(LEAVES.medical.leaveTypeName.leaveTitle!),
                            value: "male",
                            groupValue: "male",
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RadioListTile(
                            title:
                                Text(LEAVES.parental.leaveTypeName.leaveTitle!),
                            value: "male",
                            groupValue: "male",
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RadioListTile(
                            title: Text(
                                LEAVES.emergency.leaveTypeName.leaveTitle!),
                            value: "male",
                            groupValue: "male",
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RadioListTile(
                            title:
                                Text(LEAVES.unpaid.leaveTypeName.leaveTitle!),
                            value: "male",
                            groupValue: "male",
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
