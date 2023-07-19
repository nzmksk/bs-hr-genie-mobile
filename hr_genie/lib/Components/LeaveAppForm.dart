// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/LeaveFormSummary.dart';
import 'package:hr_genie/Components/LeaveTypeRadio.dart';
import 'package:hr_genie/Components/PickDate_Reason.dart';
import 'package:hr_genie/Components/ReasonTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/UploadAttach.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:intl/intl.dart';

class LeaveAppForm extends StatefulWidget {
  const LeaveAppForm({super.key});

  @override
  State<LeaveAppForm> createState() => _LeaveAppFormState();
}

class _LeaveAppFormState extends State<LeaveAppForm> {
  int? _selectedDuration = 0;
  int? _selectedHalf = 1;
  List<DateTime>? selectedDateList;
  int currentStep = 0;
  Color disabledButton = disabledButtonColor;
  Color selectedButton = selectedButtonColor;
  Color unselectedButton = unselectedButtonColor;
  String stepOneInstruction =
      "Choose leave type first and select either Full-day or Half-day ";
  @override
  void initState() {
    super.initState();
    LeaveFormCubit formCubit = context.read<LeaveFormCubit>();
    formCubit.typeOnChanged(null);
    formCubit.setDateTime(null);
  }

  static String dateFormat(DateTime dateTime) {
    return DateFormat('dd, MMMM yyyy').format(dateTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveFormCubit, LeaveFormState>(
      listener: (context, state) {
        if (state.status == LeaveStatus.sent) {
          showCustomSnackBar(context, state.applyResponse, Colors.green);
          Navigator.of(context).pop();
          // context.read<ApiServiceCubit>().doneApply();
        } else if (state.status == LeaveStatus.error) {
          showCustomSnackBar(context, state.applyResponse, Colors.red);
          // context.read<ApiServiceCubit>().doneApply();
        }
        if (currentStep == 0) {
          _selectedDuration = 0;
          context.read<LeaveFormCubit>().setDateTime(null);
          context.read<LeaveFormCubit>().setRangeDate(null, null);
        } else if (currentStep == 1) {
          context.read<LeaveFormCubit>().firstStepDone(true);
        } else if (currentStep == 2) {
          if (state.reason != null) {
            context.read<LeaveFormCubit>().thirdStepDone(true);
          }
        }
        if (state.startDate != null &&
            state.endDate != null &&
            state.secStepDone) {
          setState(() {
            currentStep = 2;
          });
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LeaveFormSummary(),
            Container(
              // color: Colors.yellow,
              height: 590.0,
              alignment: Alignment.center,
              child: Theme(
                data: ThemeData(
                  textTheme: const TextTheme().copyWith(
                    bodyLarge: const TextStyle(color: globalTextColor),
                  ),
                  // canvasColor: Colors.yellow,
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: primaryBlue,
                        secondary: Colors.red,
                      ),
                ),
                child: Stepper(
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  margin: const EdgeInsets.fromLTRB(50, 0, 10, 50),
                  currentStep: currentStep,
                  steps: getSteps(state),
                  onStepTapped: (step) => setState(
                    () {
                      final leave = context.read<LeaveFormCubit>();
                      if (step == 1) leave.secStepDone(false);

                      if (step > currentStep) return;
                      if (currentStep == 2 &&
                          state.startDate != null &&
                          state.secStepDone) {
                        leave.setDateTime(null);
                        leave.setRangeDate(null, null);
                      }
                      currentStep = step;
                    },
                  ),
                ),
              ),
            ),

            // SubmitButton(label: "Submit", onPressed: () {})
          ],
        );
      },
    );
  }

  List<Step> getSteps(state) {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Choose Leave Type"),
        content: Column(
          children: [
            const LeaveTypeRadio(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: !state.isValidLeaveType
                          ? null
                          : () {
                              context.read<LeaveFormCubit>().durationSelected(1,
                                  1); // by default half-day will be first half

                              setState(() {
                                _selectedDuration = 1;
                                currentStep = 1;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: disabledButton,
                        backgroundColor: _selectedDuration == 1
                            ? selectedButton
                            : unselectedButton,
                      ),
                      child: const Text('Full Day'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: !state.isValidLeaveType
                          ? null
                          : () {
                              context.read<LeaveFormCubit>().durationSelected(2,
                                  1); // by default half-day will be first half
                              setState(() {
                                _selectedDuration = 2;
                                _selectedHalf = 1;
                                currentStep = 1;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: disabledButton,
                        backgroundColor: _selectedDuration == 2
                            ? selectedButton
                            : unselectedButton,
                      ),
                      child: const Text('Half Day'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: Text(
                stepOneInstruction,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: unselectedButton),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Choose Date"),
        content: BlocConsumer<LeaveFormCubit, LeaveFormState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: state.duration == "full-day"
                              ? null
                              : () {
                                  context.read<LeaveFormCubit>().durationSelected(
                                      2,
                                      1); // by default half-day will be first half

                                  setState(() {
                                    _selectedHalf = 1;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: disabledButton,
                            backgroundColor: _selectedHalf == 1
                                ? selectedButton
                                : unselectedButton,
                          ),
                          child: const Text(
                            'First Half',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: state.duration == "full-day"
                              ? null
                              : () {
                                  context.read<LeaveFormCubit>().durationSelected(
                                      2,
                                      2); // by default half-day will be first half
                                  setState(() {
                                    _selectedHalf = 2;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: disabledButton,
                            backgroundColor: _selectedHalf == 2
                                ? selectedButton
                                : unselectedButton,
                          ),
                          child: const Text(
                            'Second Half',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _selectedDuration == 1 || _selectedDuration == 0
                    ? PickDateReasonRow(
                        updatedColor: checkTileColor(state),
                        dateTitle: "Pick one or more date",
                        isFullDay: true, // the calendar input will be range
                      )
                    : PickDateReasonRow(
                        updatedColor: checkTileColor(state),
                        dateTitle: "Pick one date",
                        isFullDay:
                            false, // the calendar input only for single day
                      ),
              ],
            );
          },
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Attachments"),
        content: Column(
          children: [
            const ReasonField(),
            const UploadAttachment(),
            SubmitButton(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              label: "Submit",
              onPressed: validateForm(state),
            )
          ],
        ),
      ),
    ];
  }

  Function()? validateForm(
    LeaveFormState state,
  ) {
    return state.firstStepDone && state.secStepDone && state.thirdStepDone
        ? () async {
            try {
              await context.read<LeaveFormCubit>().applyLeave(
                  leaveTypeId: state.leaveType!,
                  startDate: state.startDate!,
                  endDate: state.endDate!,
                  durationType: state.duration!,
                  reason: state.reason!,
                  attachment: null);
            } catch (e) {}
          }
        : null;
  }

  Color? checkTileColor(LeaveFormState state) {
    if (state.duration == "full-day") {
      return state.startDate != null && state.endDate != null
          ? primaryBlue
          : unselectedButton;
    } else {
      return state.startDate != null ? selectedButton : unselectedButton;
    }
  }
}
