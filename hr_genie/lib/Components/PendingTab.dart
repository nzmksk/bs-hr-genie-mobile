import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/LeaveTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:intl/intl.dart';

import '../Model/LeaveModel.dart';

class PendingTab extends StatelessWidget {
  PendingTab({super.key});
  List<Leave> leaveList = List.generate(10, (index) {
    final faker = Faker();
    return Leave(
      leaveId: faker.guid.guid(),
      employeeId: faker.person.name(),
      leaveTypeId: faker.guid.guid(),
      startDate: faker.date.dateTime(minYear: 2023, maxYear: 2024),
      endDate: faker.date.dateTime(minYear: 2023, maxYear: 2024),
      reason: faker.lorem.sentence(),
      attachment: faker.lorem.word(),
      applicationStatus: 'Pending',
      approvedRejectedBy: faker.person.name(),
      createdAt: faker.date.dateTime(minYear: 2023, maxYear: 2023),
      durationType: '',
      durationLength: 3,
      rejectReason: '',
    );
  });
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: leaveList.length,
                itemBuilder: (context, index) => LeaveTile(
                      leaveList: leaveList,
                      index: index,
                      tileColor: Colors.amber,
                      onTap: () {},
                    )),
          )
        ],
      ),
    );
  }
}
