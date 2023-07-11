// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PickDateReasonRow extends StatefulWidget {
  final bool isFullDay;
  final Color? updatedColor;
  final dynamic Function()? addFunction;
  const PickDateReasonRow({
    super.key,
    required this.dateTitle,
    required this.isFullDay,
    this.addFunction,
    this.updatedColor,
  });

  final String? dateTitle;

  @override
  State<PickDateReasonRow> createState() => _PickDateReasonRowState();
}

class _PickDateReasonRowState extends State<PickDateReasonRow> {
  DateRangePickerMonthCellStyle monthCellStyle() {
    return const DateRangePickerMonthCellStyle(
      // rangeSelectionColor: Colors.red,
      rangeTextStyle: TextStyle(color: globalTextColor),
      selectionTextStyle: TextStyle(color: Colors.red),
      disabledDatesTextStyle: TextStyle(color: instructionTextColor),
      selectionColor: primaryBlue,
      startRangeSelectionColor: primaryBlue,
      endRangeSelectionColor: primaryBlue,
      leadingDatesTextStyle: TextStyle(color: globalTextColor),
      trailingDatesTextStyle: TextStyle(color: globalTextColor),
      textStyle: TextStyle(color: globalTextColor),
      todayCellDecoration:
          BoxDecoration(shape: BoxShape.rectangle, color: instructionTextColor),
      todayTextStyle:
          TextStyle(color: primaryLightBlue, fontWeight: FontWeight.bold),
      blackoutDatesDecoration: BoxDecoration(
          color: Colors.red,
          // border: Border.all(color: const Color(0xFFF44436), width: 1),
          shape: BoxShape.circle),
      weekendDatesDecoration: BoxDecoration(
          color: Color.fromARGB(255, 61, 61, 61), shape: BoxShape.rectangle),
      blackoutDateTextStyle: TextStyle(
          color: instructionTextColor, decoration: TextDecoration.lineThrough),
    );
  }

  Future<void> pickFullDays(
      BuildContext context, List<DateTime>? filteredDates) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<LeaveFormCubit, LeaveFormState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 160),
              child: Card(
                color: primaryBlack,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SfDateRangePicker(
                        todayHighlightColor: primaryBlue,
                        headerStyle: const DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(color: globalTextColor),
                        ),
                        backgroundColor: primaryBlack,
                        controller: _datePickerController,
                        allowViewNavigation: true,
                        showNavigationArrow: true,
                        onSelectionChanged: (args) {
                          if (args.value is DateTime) {
                            print("Selected Date: ${args.value.toString()}");
                            context
                                .read<LeaveFormCubit>()
                                .setDateTime(args.value);
                          } else {
                            selectionChanged(args);
                            print("START: $start END $end");
                            context
                                .read<LeaveFormCubit>()
                                .setRangeDate(start, end);
                            // print("Selected Date: $selectedDates");
                            print(
                                "Start Date: ${_startDate} = ${state.startDate}");
                            print("End Date: ${_endDate} = ${state.endDate}");
                          }
                        },
                        enablePastDates: false,
                        monthCellStyle: monthCellStyle(),
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(color: globalTextColor)),
                          firstDayOfWeek: 1,
                          weekendDays: [6, 7],
                          // enableSwipeSelection: true,
                        ),
                        // toggleDaySelection: true,
                        extendableRangeSelectionDirection:
                            ExtendableRangeSelectionDirection.forward,
                        selectionMode: widget.isFullDay
                            ? DateRangePickerSelectionMode.range
                            : DateRangePickerSelectionMode.single,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SubmitButton(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                textColor: Colors.black,
                                buttonColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<LeaveFormCubit>()
                                      .setDateTime(null);
                                  context
                                      .read<LeaveFormCubit>()
                                      .setRangeDate(null, null);
                                  _datePickerController.selectedRange =
                                      const PickerDateRange(null, null);
                                },
                                label: "Back"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: SubmitButton(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                onPressed: state.startDate == null
                                    ? null
                                    : () {
                                        setState(() {
                                          widget.addFunction;
                                          if (state.startDate != null) {
                                            context
                                                .read<LeaveFormCubit>()
                                                .secStepDone(true);
                                          }
                                          // _datePickerController.clear();
                                          _datePickerController.selectedRange =
                                              PickerDateRange(state.startDate,
                                                  state.endDate);
                                        });
                                        Navigator.pop(context);
                                      },
                                label: "Proceed"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  late String _startDate, _endDate;
  late DateTime start, end;
  final DateRangePickerController _datePickerController =
      DateRangePickerController();
  // List<DateTime> selectedDates = [];

  @override
  void initState() {
    final DateTime today = DateTime.now();
    _startDate = DateFormat('dd, MMMM yyyy').format(today).toString();
    _endDate = DateFormat('dd, MMMM yyyy')
        .format(today.add(const Duration(days: 2)))
        .toString();
    _datePickerController.selectedRange = const PickerDateRange(null, null);
    // selectedDates = getSelectedDates(today, today.add(const Duration(days: 3)));
    super.initState();
    context.read<LeaveFormCubit>().setDateTime(null);
    context.read<LeaveFormCubit>().setRangeDate(null, null);
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
      _endDate = DateFormat('dd, MMMM yyyy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
      start = args.value.startDate;
      end = args.value.endDate ?? args.value.startDate;
    });
  }

  // void selectionChanged(
  //     DateRangePickerSelectionChangedArgs args, String? duration) {
  //   setState(() {
  //     _startDate =
  //         DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
  //     _endDate = DateFormat('dd, MMMM yyyy')
  //         .format(args.value.endDate ?? args.value.startDate)
  //         .toString();

  //     // if (duration == LeaveDuration.fullDay.value) {
  //     //   print("Duration is $duration");
  //     start = DateTime(
  //       args.value.startDate.year,
  //       args.value.startDate.month,
  //       args.value.startDate.day,
  //       00, // Set specific start time hour
  //       00, // Set specific start time minute
  //     );
  //     end = DateTime(
  //       args.value.endDate?.year ?? args.value.startDate.year,
  //       args.value.endDate?.month ?? args.value.startDate.month,
  //       args.value.endDate?.day ?? args.value.startDate.day,
  //       00, // Set specific end time hour
  //       00, // Set specific end time minute
  //     );
  //     // } else if (duration == LeaveDuration.firstHalf.value) {
  //     //   print("Duration is $duration");

  //     //   start = DateTime(
  //     //     args.value.startDate.year,
  //     //     args.value.startDate.month,
  //     //     args.value.startDate.day,
  //     //     09, // Set specific start time hour
  //     //     00, // Set specific start time minute
  //     //   );
  //     //   end = DateTime(
  //     //     args.value.endDate?.year ?? args.value.startDate.year,
  //     //     args.value.endDate?.month ?? args.value.startDate.month,
  //     //     args.value.endDate?.day ?? args.value.startDate.day,
  //     //     13, // Set specific end time hour
  //     //     00, // Set specific end time minute
  //     //   );
  //     // } else {
  //     //   print("Duration is $duration");

  //     //   start = DateTime(
  //     //     args.value.startDate.year,
  //     //     args.value.startDate.month,
  //     //     args.value.startDate.day,
  //     //     14, // Set specific start time hour
  //     //     00, // Set specific start time minute
  //     //   );
  //     //   end = DateTime(
  //     //     args.value.endDate?.year ?? args.value.startDate.year,
  //     //     args.value.endDate?.month ?? args.value.startDate.month,
  //     //     args.value.endDate?.day ?? args.value.startDate.day,
  //     //     18, // Set specific end time hour
  //     //     00, // Set specific end time minute
  //     //   );
  //     // }
  //     // Set specific time for start and end dates
  //   });
  // }

  List<DateTime> getSelectedDates(DateTime startDate, DateTime? endDate) {
    final List<DateTime> dates = [];
    final Duration difference = endDate?.difference(startDate) ?? Duration.zero;
    final int numDays = difference.inDays + 1;
    for (int i = 0; i < numDays; i++) {
      final DateTime date = startDate.add(Duration(days: i));
      dates.add(date);
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime>? dates = [];
    List<DateTime>? filteredDates = dates.where((date) {
      return date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday;
    }).toList();
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return CustomListTile(
          color: widget.updatedColor,
          margin: const EdgeInsets.fromLTRB(10, 1, 1, 1),
          title: Text(
            widget.dateTitle!,
            style: TextStyle(color: checkTextColor(state)),
          ),
          trailing: Icon(
            Icons.date_range,
            color: checkTextColor(state),
          ),
          onTap: () async {
            await pickFullDays(context, filteredDates);
          },
        );
      },
    );
  }

  Color checkTextColor(LeaveFormState state) {
    if (state.duration == "Full-Day") {
      return state.startDate != null && state.endDate != null
          ? Colors.white
          : globalTextColor;
    } else {
      return state.startDate != null ? Colors.white : globalTextColor;
    }
  }
}
