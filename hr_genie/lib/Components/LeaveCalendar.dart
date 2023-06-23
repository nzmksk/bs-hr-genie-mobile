import 'package:flutter/material.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({super.key});

  @override
  State<LeaveCalendar> createState() => _LeaveCalendarState();
}

class _LeaveCalendarState extends State<LeaveCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      firstDayOfWeek: 6,
      view: CalendarView.month,
      dataSource: LeaveDataSource(_getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          // navigationDirection: MonthNavigationDirection.vertical,
          monthCellStyle: MonthCellStyle(),
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
    ));
  }

  List<Leave> _getDataSource() {
    final List<Leave> leave = <Leave>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    leave.add(Leave(
        leaveId: "Annual Leave",
        employeeId: "employeeId",
        leaveTypeId: "Annual Leave",
        startDate: DateTime(2023, 6, 30, 9, 00),
        endDate: DateTime(2023, 7, 2, 13, 00),
        reason: "reason",
        attachment: "attachment",
        applicationStatus: "Pending",
        approvedRejectedBy: "approvedRejectedBy"));
    return leave;
  }
}

class LeaveDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  LeaveDataSource(List<Leave> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getLeaveData(index).startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return _getLeaveData(index).endDate;
  }

  @override
  String getSubject(int index) {
    return _getLeaveData(index).leaveId;
  }

  @override
  Color getColor(int index) {
    String leaveType = _getLeaveData(index).leaveTypeId;
    switch (leaveType) {
      case "Annual Leave":
        return Colors.orange;
      case "Paternity Leave":
        return Colors.yellowAccent;
      case "Medical Leave":
        return Colors.greenAccent;
      case "Emergency Leave":
        return Colors.redAccent;
      case "Unpaid Leave":
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
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
