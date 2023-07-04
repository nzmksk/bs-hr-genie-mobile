// ignore_for_file: library_private_types_in_public_api, avoid_print

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
  String? _leaveType;
  TextStyle radioTextStyle = const TextStyle(
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          height: 260,
          child: Card(
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              listTileTheme: const ListTileThemeData(
                                horizontalTitleGap:
                                    0, //here adjust based on your need
                              ),
                            ),
                            child: RadioListTile(
                              title: Text(
                                LEAVES.annual.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                LEAVES.annual.quota!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: TYPE.annual.values,
                              groupValue: _leaveType,
                              onChanged: (value) {
                                setState(() {
                                  _leaveType = value;
                                });
                                context
                                    .read<LeaveFormCubit>()
                                    .typeOnChanged(_leaveType);
                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              listTileTheme: const ListTileThemeData(
                                horizontalTitleGap:
                                    0, //here adjust based on your need
                              ),
                            ),
                            child: RadioListTile(
                              title: Text(
                                LEAVES.emergency.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                LEAVES.emergency.quota!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: TYPE.emergency.values,
                              groupValue: _leaveType,
                              onChanged: (value) {
                                setState(() {
                                  _leaveType = value;
                                });
                                context
                                    .read<LeaveFormCubit>()
                                    .typeOnChanged(_leaveType);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              listTileTheme: const ListTileThemeData(
                                horizontalTitleGap:
                                    0, //here adjust based on your need
                              ),
                            ),
                            child: RadioListTile(
                              title: Text(
                                LEAVES.medical.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                LEAVES.medical.quota!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: TYPE.medical.values,
                              groupValue: _leaveType,
                              onChanged: (value) {
                                setState(() {
                                  _leaveType = value;
                                });
                                context
                                    .read<LeaveFormCubit>()
                                    .typeOnChanged(_leaveType);
                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              listTileTheme: const ListTileThemeData(
                                horizontalTitleGap:
                                    0, //here adjust based on your need
                              ),
                            ),
                            child: RadioListTile(
                              title: Text(
                                LEAVES.parental.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                LEAVES.parental.quota!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: TYPE.parental.values,
                              groupValue: _leaveType,
                              onChanged: (value) {
                                setState(() {
                                  _leaveType = value;
                                });
                                context
                                    .read<LeaveFormCubit>()
                                    .typeOnChanged(_leaveType);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          listTileTheme: const ListTileThemeData(
                            horizontalTitleGap:
                                0, //here adjust based on your need
                          ),
                        ),
                        child: RadioListTile(
                          title: Text(
                            LEAVES.unpaid.leaveTypeName.leaveTitle!,
                            style: radioTextStyle,
                          ),
                          subtitle: Text(
                            LEAVES.unpaid.quota!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          value: TYPE.unpaid.values,
                          groupValue: _leaveType,
                          onChanged: (value) {
                            setState(() {
                              _leaveType = value;
                            });
                            context
                                .read<LeaveFormCubit>()
                                .typeOnChanged(_leaveType);
                          },
                        ),
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
