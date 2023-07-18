// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CancelApprovalButton.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/LeaveTileInfo.dart';
import 'package:hr_genie/Components/LimitedTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TimerButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RequestDetailPage extends StatelessWidget {
  final Leave leaveModel;

  const RequestDetailPage({super.key, required this.leaveModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LeaveTileInfo(
                  label: 'Employee Name',
                  //TODO: replace with employee name
                  value: '${leaveModel.firstName} ${leaveModel.lastName}',
                ),
                LeaveTileInfo(
                  label: 'Leave Type',
                  value: checkLeaveType(leaveModel.leaveTypeId.toString()),
                ),
                LeaveTileInfo(
                  label: 'Date',
                  value:
                      "${DateFormat.yMMMd('en-US').format(DateTime.parse(leaveModel.startDate!))} to ${DateFormat.yMMMEd('en-US').format(DateTime.parse(leaveModel.endDate!))}",
                ),
                LeaveTileInfo(
                  label: 'Duration',
                  value: '${truncatNum(leaveModel.durationLength)} Days',
                ),
                LeaveTileInfo(
                  label: 'Reason',
                  value: leaveModel.reason,
                ),
                LeaveTileInfo(
                  label: 'Attachment',
                  value: leaveModel.attachment,
                ),
                Visibility(
                  visible: leaveModel.applicationStatus != 'pending',
                  child: LeaveTileInfo(
                    color: leaveModel.applicationStatus == 'approved'
                        ? Colors.green
                        : leaveModel.applicationStatus == 'rejected'
                            ? Colors.red
                            : cardColor,
                    label: 'Status',
                    value: capitalize(leaveModel.applicationStatus),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Visibility(
                  visible: leaveModel.applicationStatus == 'approved',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Cancel this leave application cannot be undone.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: instructionTextColor, fontSize: 13),
                      ),
                      SubmitButton(
                        margin: const EdgeInsets.only(bottom: 25, top: 10),
                        label: "Cancel",
                        onPressed: () async {
                          await requestDecision(
                              controller: controller,
                              context: context,
                              title: 'Cancel',
                              decision: 'cancelled',
                              leaveId: leaveModel.leaveId!);
                          ;
                        },
                        buttonColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: leaveModel.applicationStatus == 'pending',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "You can cancel your leave application during pending only. Otherwise you'll need to inform your manager",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: instructionTextColor, fontSize: 13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SubmitButton(
                              margin:
                                  const EdgeInsets.only(bottom: 25, top: 10),
                              label: "Reject",
                              onPressed: () async {
                                String? rejectReason;
                                requestDecision(
                                    controller: controller,
                                    context: context,
                                    title: 'Reject',
                                    decision: 'rejected',
                                    leaveId: leaveModel.leaveId!);
                                // await rejectDialog(
                                //     context, controller, rejectReason);
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
                              margin:
                                  const EdgeInsets.only(bottom: 25, top: 10),
                              label: "Approve",
                              onPressed: () {
                                requestDecision(
                                    controller: controller,
                                    leaveId: leaveModel.leaveId!,
                                    title: 'Approve ',
                                    context: context,
                                    decision: 'approved');
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
      ),
    );
  }

  Future<dynamic> cancelDialog(BuildContext context, bool confirmCancel) {
    return showDialog(
      context: context,
      builder: (_) {
        Future.delayed(const Duration(seconds: 5), () {
          if (confirmCancel) {
            //TODO: put and cancel function here
            context
                .read<ApiServiceCubit>()
                .responseApplyRequest(leaveModel, 'cancelled', null, false);
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: CancelAppButton(
            height: 200,
            label: 'Undo',
            buttonColor: Colors.white,
            textColor: primaryBlack,
            onPressed: () {
              confirmCancel == true;
              print('Confirm : $confirmCancel');
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  // Future<dynamic> rejectDialog(BuildContext context,
  //     TextEditingController controller, String? rejectReason) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (_) {
  //         return BlocBuilder<LeaveFormCubit, LeaveFormState>(
  //           builder: (context, state) {
  //             return AlertDialog(
  //               actionsPadding:
  //                   const EdgeInsets.only(left: 20, right: 20, bottom: 20),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20)),
  //               title: const Text('Reject Reason'),
  //               content: SizedBox(
  //                 height: 120,
  //                 child: LimitedTextField(
  //                     onchanged: (value) {
  //                       context
  //                           .read<LeaveFormCubit>()
  //                           .inputChecking(value, true);
  //                     },
  //                     controller: controller),
  //               ),
  //               actions: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Expanded(
  //                       flex: 1,
  //                       child: SubmitButton(
  //                           textColor: primaryBlack,
  //                           buttonColor: globalTextColor,
  //                           label: 'Cancel',
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           }),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     Expanded(
  //                         flex: 1,
  //                         child: SubmitButton(
  //                             label: 'Proceed',
  //                             onPressed: !state.rejectReasonNotEmpty
  //                                 ? null
  //                                 : () => requestDecision(
  //                                     leaveId: leaveModel.leaveId!,
  //                                     title: 'Reject ',
  //                                     context: context,
  //                                     rejectReason: rejectReason,
  //                                     // content:
  //                                     //     'You will reject this application and this cannot be undo. Proceed?',
  //                                     decision: 'rejected'))),
  //                   ],
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       });
  // }

  Future<dynamic> requestDecision(
      {required BuildContext context,
      required String title,
      required String decision,
      required String leaveId,
      required TextEditingController controller,
      String? rejectReason}) {
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
                                      color: decision == 'approved'
                                          ? Colors.green.shade700
                                          : Colors.red)),
                              const TextSpan(text: '?')
                            ]))),
                    content: decision == 'rejected'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 120,
                                child: LimitedTextField(
                                    onchanged: (value) {
                                      context
                                          .read<LeaveFormCubit>()
                                          .inputChecking(value, true);
                                    },
                                    controller: controller),
                              ),
                            ],
                          )
                        : const Text(
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
                                  Navigator.of(context).pop(true);
                                  Navigator.of(context).pop(true);
                                }),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: TimerButton(
                              label: 'Yes',
                              onPressed: () async {
                                await context
                                    .read<ApiServiceCubit>()
                                    .responseApplyRequest(leaveModel, decision,
                                        rejectReason, false);
                                Navigator.of(context).pop(true);
                                Navigator.of(context).pop(true);
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
