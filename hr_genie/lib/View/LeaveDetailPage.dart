import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/LeaveTileInfo.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class LeaveDetailPage extends StatelessWidget {
  final Leave leaveModel;
  const LeaveDetailPage({super.key, required this.leaveModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Column(
              children: [
                const CustomAppBar(title: "Leave Review"),
                Container(
                  height: 20,
                  color: primaryBlue,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Applied on ${DateFormat.yMMMMEEEEd('en-US').format(DateTime.parse(leaveModel.createdAt!))}",
                      style: const TextStyle(
                          color: primaryLightBlue, fontSize: 13),
                    ),
                  ),
                ),
              ],
            )),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: LeaveTileInfo(
                  label: 'Leave Type',
                  value: checkLeaveType(leaveModel.leaveTypeId!.toString()),
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveTileInfo(
                  label: 'Date',
                  value:
                      "${DateFormat.yMMMd('en-US').format(DateTime.parse(leaveModel.startDate!))} to ${DateFormat.yMMMEd('en-US').format(DateTime.parse(leaveModel.endDate!))}",
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveTileInfo(
                  label: 'Duration',
                  value: '${truncatNum(leaveModel.durationLength)} Days',
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveTileInfo(
                  label: 'Reason',
                  value: leaveModel.reason,
                ),
              ),
              Expanded(
                child: LeaveTileInfo(
                  label: 'Attachment',
                  value: leaveModel.attachment,
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveTileInfo(
                  label: 'Status',
                  value: capitalize(leaveModel.applicationStatus),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "You can cancel your leave application during pending only. Otherwise you'll need to inform your manager",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: instructionTextColor, fontSize: 13),
                    ),
                    SubmitButton(
                      margin: const EdgeInsets.only(bottom: 25, top: 10),
                      label: "Cancel",
                      onPressed: leaveModel.applicationStatus == "pending"
                          ? () async {
                              await context
                                  .read<ApiServiceCubit>()
                                  .responseApplyRequest(
                                      leaveModel, 'cancelled', null, true);
                              Navigator.of(context).pop(true);
                            }
                          : null,
                      buttonColor: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
