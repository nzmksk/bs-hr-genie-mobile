import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TimerButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/View/LeaveDetailPage.dart';
import 'package:intl/intl.dart';

class RequestDetailPage extends StatelessWidget {
  final Leave leaveModel;

  const RequestDetailPage({super.key, required this.leaveModel});

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
                      'Applied on ${DateFormat.yMMMMEEEEd('en-US').format(DateTime.parse(leaveModel.createdAt!))}',
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
                child: LeaveDetailInfo(
                  label: 'Employee Name',
                  //TODO: replace with employee name
                  value: checkLeaveType(leaveModel.leaveTypeId.toString()),
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveDetailInfo(
                  label: 'Leave Type',
                  value: checkLeaveType(leaveModel.leaveTypeId.toString()),
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveDetailInfo(
                  label: 'Date',
                  value:
                      "${DateFormat.yMMMd('en-US').format(DateTime.parse(leaveModel.startDate!))} to ${DateFormat.yMMMEd('en-US').format(DateTime.parse(leaveModel.endDate!))}",
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveDetailInfo(
                  label: 'Duration',
                  value: '${truncatNum(leaveModel.durationLength)} Days',
                ),
              ),
              Expanded(
                flex: 1,
                child: LeaveDetailInfo(
                  label: 'Reason',
                  value: leaveModel.reason,
                ),
              ),
              Expanded(
                child: LeaveDetailInfo(
                  label: 'Attachment',
                  value: leaveModel.attachment,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SubmitButton(
                            margin: const EdgeInsets.only(bottom: 25, top: 10),
                            label: "Reject",
                            onPressed: () {
                              requestDecision(
                                  context: context,
                                  content:
                                      'You will reject this application and this cannot be undo. Proceed?',
                                  isApproved: false);
                            },
                            buttonColor: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: SubmitButton(
                            margin: const EdgeInsets.only(bottom: 25, top: 10),
                            label: "Approve",
                            onPressed: () {
                              requestDecision(
                                  context: context,
                                  content:
                                      'You will APPROVE this application and this cannot be undo. Proceed?',
                                  isApproved: true);
                            },
                            buttonColor: primaryBlue,
                          ),
                        ),
                      ],
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

  Future<dynamic> requestDecision(
      {required BuildContext context,
      required String content,
      required bool isApproved}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              actionsPadding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text('Confirm?'),
              content: Text(content),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubmitButton(
                          textColor: primaryBlack,
                          buttonColor: globalTextColor,
                          label: 'Cancel',
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TimerButton(
                          label: 'Yes',
                          onPressed: () {
                            //TODO: PUT leave application to reject
                          }),
                    ),
                  ],
                ),
              ],
            ));
  }
}
