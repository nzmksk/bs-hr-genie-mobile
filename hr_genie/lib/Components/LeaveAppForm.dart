import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/LeaveTypeRadio.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/UploadAttach.dart';

class LeaveAppForm extends StatelessWidget {
  const LeaveAppForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "New Application",
          ),
          const LeaveTypeRadio(),
          CustomListTile(
            title: const Text("Date"),
            trailing: const Icon(Icons.add_circle),
            onTap: () {},
          ),
          CustomListTile(
            title: const Text("Reason"),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const UploadAttachment(),
          SubmitButton(label: "Submit", onPressed: () {})
        ],
      ),
    );
  }
}
