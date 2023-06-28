import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/LeaveTypeRadio.dart';
import 'package:hr_genie/Components/LimitedTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/UploadAttach.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveAppForm extends StatefulWidget {
  const LeaveAppForm({super.key});

  @override
  State<LeaveAppForm> createState() => _LeaveAppFormState();
}

class _LeaveAppFormState extends State<LeaveAppForm> {
  String? dateTitle = "Pick Date";
  List<DateTime>? dates = [];
  int? _selectedValue = 1;
  List<DateTime>? selectedDateList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime>? filteredDates = dates?.where((date) {
      return date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday;
    }).toList();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "New Application",
          ),
          const LeaveTypeRadio(),
          CustomListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedValue = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedValue == 1 ? Colors.blue : Colors.grey,
                    ),
                    child: Text('Full Day'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedValue = 2;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedValue == 2 ? Colors.blue : Colors.grey,
                    ),
                    child: Text('Half Day'),
                  ),
                ),
              ],
            ),
          ),
          _selectedValue == 1
              ? CustomListTile(
                  title: Text(dateTitle!),
                  trailing: const Icon(Icons.add_circle),
                  onTap: () async {
                    pickFullDays(context, filteredDates);
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomListTile(
                      title: Text(dateTitle!),
                      trailing: const Icon(Icons.add_circle),
                      onTap: () {
                        pickFullDays(context, filteredDates);
                      },
                    ),
                    CustomListTile(
                      title: const Text("Cajndkjad"),
                      onTap: () {},
                    ),
                  ],
                ),
          CustomListTile(
            title: const Text("Reason"),
            trailing: const Icon(Icons.edit),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 300),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: LimitedTextField(),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: SubmitButton(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      label: "ADD",
                                      onPressed: () {}))
                            ],
                          ),
                        ),
                      ));
                },
              );
            },
          ),
          const UploadAttachment(),
          SubmitButton(label: "Submit", onPressed: () {})
        ],
      ),
    );
  }

  Future<void> pickFullDays(
      BuildContext context, List<DateTime>? filteredDates) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 200),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SfDateRangePicker(
                // allowViewNavigation: true,
                showNavigationArrow: true,
                onSelectionChanged: (args) {
                  if (args.value is DateTime) {
                    print("Selected Date: ${args.value.toString()}");
                  } else if (args.value is List<DateTime>) {
                    print("Chosen Date: ${args.value.toString()}");
                  }
                },
                enablePastDates: false,
                monthCellStyle: monthCellStyle(),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  weekendDays: [6, 7],
                ),
                selectionMode: DateRangePickerSelectionMode.extendableRange,
              ),
            ),
          ),
        );
      },
    );
  }

  DateRangePickerMonthCellStyle monthCellStyle() {
    return DateRangePickerMonthCellStyle(
      blackoutDatesDecoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(color: const Color(0xFFF44436), width: 1),
          shape: BoxShape.circle),
      weekendDatesDecoration: BoxDecoration(
          color: const Color(0xFFDFDFDF),
          border: Border.all(color: const Color(0xFFF1F1F1), width: 1),
          shape: BoxShape.rectangle),
      specialDatesDecoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: const Color(0xFF2B732F), width: 1),
          shape: BoxShape.circle),
      blackoutDateTextStyle: const TextStyle(
          color: Colors.white, decoration: TextDecoration.lineThrough),
      specialDatesTextStyle: const TextStyle(color: Colors.white),
    );
  }
}
