import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/SummaryTextDisplay.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:intl/intl.dart';

class LeaveFormSummary extends StatelessWidget {
  const LeaveFormSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          width: 360,
          height: 130,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // textDirection: TextDirection.ltr,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Type of Leave",
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Duration",
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reason",
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selected Date",
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "File",
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SummaryTextDisplay(
                          value: state.leaveType,
                        ),
                        SummaryTextDisplay(
                          value: state.duration,
                        ),
                        SummaryTextDisplay(
                          value: characterCheck(state),
                        ),
                        SummaryTextDisplay(
                          value: state.startDate != null
                              ? startDateParser(state)
                              : "",
                        ),
                        SummaryTextDisplay(
                          value: state.attachment.toString() ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String startDateParser(LeaveFormState state) => state.endDate == null
      ? DateFormat.yMMMMd().format(state.startDate!)
      : "${DateFormat.yMMMMd().format(state.startDate!)} - ${DateFormat.yMMMMd().format(state.endDate!)}";

  String? characterCheck(LeaveFormState state) {
    return state.reason == null
        ? null
        : state.reason!.length > 30
            ? "${state.reason!.substring(0, 29)} ..."
            : state.reason;
  }
}
