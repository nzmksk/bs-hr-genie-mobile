import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/View/EmptyMyLeave.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({super.key});

  @override
  State<LeaveCalendar> createState() => _LeaveCalendarState();
}

class _LeaveCalendarState extends State<LeaveCalendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ApiServiceCubit, ApiServiceState>(
        builder: (context, state) {
          if (state.myLeaveList == null) {
            return const EmptyMyLeave();
          }
          return Scaffold(
              body: SfCalendar(
            todayHighlightColor: primaryBlue,
            viewHeaderStyle: const ViewHeaderStyle(
                dayTextStyle: TextStyle(color: globalTextColor)),
            headerStyle: const CalendarHeaderStyle(
                textStyle: TextStyle(color: globalTextColor)),
            cellBorderColor: globalTextColor,
            firstDayOfWeek: 1,
            view: CalendarView.month,
            dataSource: LeaveDataSource(state.myLeaveList!
                .where((element) => element!.applicationStatus == 'approved')
                .toList()),
            monthViewSettings: MonthViewSettings(
                showAgenda: true,
                agendaStyle: const AgendaStyle(
                    dateTextStyle: TextStyle(color: globalTextColor),
                    dayTextStyle: TextStyle(color: globalTextColor)),
                monthCellStyle: MonthCellStyle(
                    todayBackgroundColor: primaryBlue,
                    textStyle: const TextStyle(
                      color: globalTextColor,
                    ),
                    leadingDatesTextStyle:
                        TextStyle(color: Colors.grey.shade800),
                    trailingDatesTextStyle:
                        TextStyle(color: Colors.grey.shade800)),
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
          ));
        },
      ),
    );
  }

  // List<Leave?>? _getDataSource(List<Leave?>? leave) {
  //   // leave.add();
  //   return leave;
  // }
}

class LeaveDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  LeaveDataSource(List<Leave?>? source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(_getLeaveData(index).startDate!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(_getLeaveData(index).endDate!);
  }

  @override
  String getSubject(int index) {
    String id = _getLeaveData(index).leaveTypeId!.toString();
    return checkLeaveType(id);
  }

  @override
  Color getColor(int index) {
    // switch (index) {
    //   case 1:
    //     return Colors.orange;
    //   case 3:
    //     return Colors.yellowAccent;
    //   case 2:
    //     return Colors.greenAccent;
    //   case 4:
    //     return Colors.redAccent;
    //   case 5:
    //     return Colors.grey;
    //   default:
    //     return Colors.blueGrey;
    // }
    return Colors.green.shade800;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Leave _getLeaveData(int index) {
    final dynamic leave = appointments![index];
    late final Leave leaveData;
    if (leave is Leave) {
      leaveData = leave;
    }

    return leaveData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
