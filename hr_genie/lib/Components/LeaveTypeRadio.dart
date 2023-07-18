// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/LeaveCategories.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
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
    color: globalTextColor,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        num? annual = state.leaveQuotaList?[0]!.quota ?? 0;
        num? medical = state.leaveQuotaList?[1]!.quota ?? 0;
        num? parental = state.leaveQuotaList?[2]!.quota ?? 0;
        num? emergency = state.leaveQuotaList?[3]!.quota ?? 0;
        num? unpaid = state.leaveQuotaList?[4]!.quota ?? 0;
        String suffix = 'Days remaining';
        return Container(
          height: 230,
          child: Card(
            color: cardColor,
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
                              fillColor: MaterialStateProperty.all(primaryBlue),
                              title: Text(
                                LEAVES.annual.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                "$annual $suffix",
                                style: const TextStyle(
                                    fontSize: 12, color: subtitleTextColor),
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
                              fillColor: MaterialStateProperty.all(primaryBlue),
                              title: Text(
                                LEAVES.emergency.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                "$emergency $suffix",
                                style: const TextStyle(
                                    fontSize: 12, color: subtitleTextColor),
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
                              fillColor: MaterialStateProperty.all(primaryBlue),
                              title: Text(
                                LEAVES.medical.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                "$medical $suffix",
                                style: const TextStyle(
                                    fontSize: 12, color: subtitleTextColor),
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
                              fillColor: MaterialStateProperty.all(primaryBlue),
                              title: Text(
                                LEAVES.parental.leaveTypeName.leaveTitle!,
                                style: radioTextStyle,
                              ),
                              subtitle: Text(
                                "$parental $suffix",
                                style: const TextStyle(
                                    fontSize: 12, color: subtitleTextColor),
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
                          fillColor: MaterialStateProperty.all(primaryBlue),
                          title: Text(
                            LEAVES.unpaid.leaveTypeName.leaveTitle!,
                            style: radioTextStyle,
                          ),
                          subtitle: Text(
                            "$unpaid $suffix",
                            style: const TextStyle(
                                fontSize: 12, color: subtitleTextColor),
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
