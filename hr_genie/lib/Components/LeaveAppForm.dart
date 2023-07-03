import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/LeaveTypeRadio.dart';
import 'package:hr_genie/Components/PickDate_Reason.dart';
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
  String? dateTitle = "Pick Date";
  int? _selectedDuration = 0;
  int? _selectedHalf = 1;
  List<DateTime>? selectedDateList;

  static String dateFormat(DateTime dateTime) {
    return DateFormat('dd, MMMM yyyy').format(dateTime).toString();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "New Application",
              ),
              const LeaveTypeRadio(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LeaveFormCubit>().durationSelected(
                              1, 1); // by default half-day will be first half

                          setState(() {
                            _selectedDuration = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedDuration == 1
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: const Text('Full Day'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<LeaveFormCubit>().durationSelected(
                              2, 1); // by default half-day will be first half
                          setState(() {
                            _selectedDuration = 2;
                            _selectedHalf = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedDuration == 2
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: const Text('Half Day'),
                      ),
                    ),
                  ],
                ),
              ),
              _selectedDuration == 1 || _selectedDuration == 0
                  ? PickDateReasonRow(
                      dateTitle: dateTitle,
                      isFullDay: true, // the calendar input will be range
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PickDateReasonRow(
                          dateTitle: dateTitle,
                          isFullDay:
                              false, // the calendar input only for single day
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<LeaveFormCubit>().durationSelected(
                                        2,
                                        1); // by default half-day will be first half

                                    setState(() {
                                      _selectedHalf = 1;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _selectedHalf == 1
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  child: const Text('First half'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<LeaveFormCubit>().durationSelected(
                                        2,
                                        2); // by default half-day will be first half

                                    setState(() {
                                      _selectedHalf = 2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _selectedHalf == 2
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  child: const Text('Second Half'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              Text('Duration: ${state.duration ?? "No duration added"}'),
              // Text(
              //     'Single Date: ${DateFormat('dd, MMMM yyyy').format(state.startDate!).toString() ?? "No date added"}'),
              Text(
                  'How many Day: ${state.dateRange?.length ?? "No date added"}'),
              Text('Reason: ${state.reason ?? "No reason added"}'),
              // const UploadAttachment(),
              const SizedBox(
                height: 10,
              ),
              SubmitButton(label: "Submit", onPressed: () {})
            ],
          ),
        );
      },
    );
  }
}
