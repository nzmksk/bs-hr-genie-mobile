import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/LeaveFormSummary.dart';
import 'package:hr_genie/Components/LeaveTypeRadio.dart';
import 'package:hr_genie/Components/PickDate_Reason.dart';
import 'package:hr_genie/Components/ReasonTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/UploadAttach.dart';
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
  @override
  void initState() {
    super.initState();
    // setState(() {
    context.read<LeaveFormCubit>().typeOnChanged(null);
    context.read<LeaveFormCubit>().setDateTime(null);

    // });
  }

  static String dateFormat(DateTime dateTime) {
    return DateFormat('dd, MMMM yyyy').format(dateTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveFormCubit, LeaveFormState>(
      listener: (context, state) {
        if (currentStep == 0) {
          _selectedDuration = 0;
          context.read<LeaveFormCubit>().setDateTime(null);
          context.read<LeaveFormCubit>().setRangeDate(null, null);
        } else if (currentStep == 1) {
          context.read<LeaveFormCubit>().firstStepDone();
          print("Step 1 : Done");
          // context.read<LeaveFormCubit>().setDateTime(null);
          // context.read<LeaveFormCubit>().setRangeDate(null, null);
        } else if (currentStep == 2) {
          context.read<LeaveFormCubit>().secStepDone();
          print("Step 2 : Done");
          if (state.reason != null) {
            context.read<LeaveFormCubit>().thirdStepDone();
            print("Step 3 : Done");
          }
        }
        if (state.startDate != null && currentStep == 1) {
          setState(() {
            currentStep == 2;
          });
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red,
                height: 230.0,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LeaveFormSummary(),
                  ],
                ),
              ),
              Container(
                // color: Colors.yellow,
                height: 650.0,
                alignment: Alignment.center,
                child: Stepper(
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  margin: const EdgeInsets.fromLTRB(50, 0, 10, 50),
                  currentStep: currentStep,
                  steps: getSteps(state),
                  onStepTapped: (step) => setState(
                    () {
                      if (step > currentStep) return;
                      if (currentStep == 2 && state.startDate != null) {
                        final leave = context.read<LeaveFormCubit>();
                        leave.setDateTime(null);
                        leave.setRangeDate(null, null);
                      }
                      currentStep = step;
                    },
                  ),
                ),
              ),

              // SubmitButton(label: "Submit", onPressed: () {})
            ],
          ),
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
              margin: const EdgeInsets.symmetric(horizontal: 5),
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
                        backgroundColor:
                            _selectedDuration == 1 ? Colors.blue : Colors.grey,
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
                        backgroundColor:
                            _selectedDuration == 2 ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('Half Day'),
                    ),
                  ),
                ],
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
          listener: (context, state) {
            setState(() {
              if (state.startDate != null && state.endDate != null) {
                currentStep = 2;
              }
            });
          },
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
                          onPressed: state.duration == "Full-Day"
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
                            backgroundColor:
                                _selectedHalf == 1 ? Colors.blue : Colors.grey,
                          ),
                          child: const Text('First Half'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: state.duration == "Full-Day"
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
                            backgroundColor:
                                _selectedHalf == 2 ? Colors.blue : Colors.grey,
                          ),
                          child: const Text('Second Half'),
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
                        addFunction: () {
                          currentStep = 2;
                        },
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

  Function()? validateForm(LeaveFormState state) {
    return state.firstStepDone && state.secStepDone && state.thirdStepDone
        ? () {}
        : null;
  }

  Color? checkTileColor(LeaveFormState state) {
    if (state.duration == "Full-Day") {
      return state.startDate != null && state.endDate != null
          ? Colors.indigo
          : Colors.grey[400];
    } else {
      return state.startDate != null ? Colors.indigo : Colors.grey[400];
    }
  }
}
