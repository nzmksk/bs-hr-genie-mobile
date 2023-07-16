import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TimerButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/View/LeaveDetailPage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

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
                  value: '${leaveModel.firstName} ${leaveModel.lastName}',
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
                                  leaveId: leaveModel.leaveId!,
                                  title: 'Reject ',
                                  context: context,
                                  // content:
                                  //     'You will reject this application and this cannot be undo. Proceed?',
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
                                  leaveId: leaveModel.leaveId!,
                                  title: 'Approve ',
                                  context: context,
                                  // content:
                                  //     'You will APPROVE this application and this cannot be undo. Proceed?',
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
      required String title,
      required bool isApproved,
      required String leaveId}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => BlocBuilder<ApiServiceCubit, ApiServiceState>(
              builder: (context, state) {
                print('STATUS Dialog: ${state.status}');
                if (state.status == ApiServiceStatus.loading) {
                  return AlertDialog(
                    content: Lottie.asset(
                      'assets/loading.json',
                      animate: true,
                      repeat: true,
                    ),
                  );
                } else if (state.status == ApiServiceStatus.initial) {
                  return AlertDialog(
                    actionsPadding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Center(
                        child: RichText(
                            textScaleFactor: 2,
                            text: TextSpan(children: [
                              const TextSpan(text: 'Confirm '),
                              TextSpan(
                                  text: title,
                                  style: TextStyle(
                                      color: isApproved
                                          ? Colors.green.shade700
                                          : Colors.red)),
                              const TextSpan(text: '?')
                            ]))),
                    content: const Text(
                      'This action cannot be undone',
                      style: TextStyle(color: instructionTextColor),
                      textAlign: TextAlign.center,
                    ),
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

                                // printGreen(
                                //     '"leaveId": ${leaveModel.leaveId},\n"employeeId": ${leaveModel.employeeId},\n"leaveTypeId": ${leaveModel.leaveTypeId},\n"startDate": ${leaveModel.startDate},\n"endDate": ${leaveModel.endDate},\n "duration": ${leaveModel.durationType},\n"durationLength": ${leaveModel.durationLength},\n "reason": ${leaveModel.reason},\n"attachment": ${leaveModel.attachment},\n"applicationStatus": "approved",\n"approvedRejectedBy": null,\n"rejectReason": null');
                                context
                                    .read<ApiServiceCubit>()
                                    .sendApproval(leaveModel);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state.status == ApiServiceStatus.success) {
                  return AlertDialog(
                    content: Lottie.asset(
                      'assets/success.json',
                      animate: true,
                      repeat: false,
                    ),
                  );
                } else {
                  return const AlertDialog(
                    content: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ));
  }
}
