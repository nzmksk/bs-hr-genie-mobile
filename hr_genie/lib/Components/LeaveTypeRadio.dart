import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/LeaveCategories.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:hr_genie/Controller/Services/LeaveCategory.dart';

class LeaveTypeRadio extends StatefulWidget {
  const LeaveTypeRadio({Key? key}) : super(key: key);

  @override
  _LeaveTypeRadioState createState() => _LeaveTypeRadioState();
}

class _LeaveTypeRadioState extends State<LeaveTypeRadio> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 260,
          child: Card(
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(15, 0, 150, 0),
                    // padding: const EdgeInsets.all(5),
                    child: const Text(
                      "Type of leave",
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          RadioType(
                            title: LEAVES.annual.leaveTypeName.leaveTitle!,
                            subtitle: LEAVES.annual.quota,
                            value: TYPE.annual.values,
                          ),
                          RadioType(
                            title: LEAVES.medical.leaveTypeName.leaveTitle!,
                            subtitle: LEAVES.medical.quota,
                            value: TYPE.medical.values,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          RadioType(
                            title: LEAVES.emergency.leaveTypeName.leaveTitle!,
                            subtitle: LEAVES.emergency.quota,
                            value: TYPE.emergency.values,
                          ),
                          RadioType(
                            title: LEAVES.parental.leaveTypeName.leaveTitle!,
                            subtitle: LEAVES.parental.quota,
                            value: TYPE.parental.values,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioType(
                        title: LEAVES.unpaid.leaveTypeName.leaveTitle!,
                        subtitle: LEAVES.unpaid.quota,
                        value: TYPE.unpaid.values,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RadioType extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? value;
  const RadioType({super.key, this.title, this.subtitle, this.value});

  @override
  State<RadioType> createState() => _RadioTypeState();
}

class _RadioTypeState extends State<RadioType> {
  String? _leaveType;
  TextStyle radioTextStyle = const TextStyle(
    fontSize: 15,
  );
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: const ListTileThemeData(
          horizontalTitleGap: 0, //here adjust based on your need
        ),
      ),
      child: RadioListTile(
        title: Text(
          widget.title!,
          style: radioTextStyle,
        ),
        subtitle: Text(
          widget.subtitle!,
          style: const TextStyle(fontSize: 12),
        ),
        value: widget.value!,
        groupValue: _leaveType,
        onChanged: (value) {
          setState(() {
            _leaveType = value;
          });
        },
      ),
    );
  }
}
