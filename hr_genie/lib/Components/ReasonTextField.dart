import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/LimitedTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class ReasonField extends StatefulWidget {
  const ReasonField({super.key});

  @override
  State<ReasonField> createState() => _ReasonFieldState();
}

class _ReasonFieldState extends State<ReasonField> {
  FocusNode _focus = FocusNode();

  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      reasonController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(() {
      reasonController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return CustomListTile(
          color: state.reason != null ? Colors.indigo : Colors.grey[200],
          margin: const EdgeInsets.fromLTRB(9, 1, 10, 1),
          title: Text(
            "Reason",
            style: TextStyle(
                color: state.reason != null ? Colors.white : Colors.black),
          ),
          trailing: Icon(
            Icons.edit,
            color: state.reason != null ? Colors.white : Colors.black,
          ),
          onTap: () {
            insertReason(context, reasonController);
          },
        );
      },
    );
  }

  Future<dynamic> insertReason(
      BuildContext context, TextEditingController reasonController) {
    setState(() {
      reasonController.clear();
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<LeaveFormCubit, LeaveFormState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.fromLTRB(30, 150, 30, 350),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: LimitedTextField(
                          focus: _focus,
                          onchanged: (value) {
                            context.read<LeaveFormCubit>().inputChecking(value);
                          },
                          controller: reasonController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Once you add a reason, you can remove by tap on remove button without filling the field or you can edit by filling the text field and tap on edit",
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SubmitButton(
                              textColor: Colors.grey.shade600,
                              buttonColor:
                                  MaterialStateProperty.all(Colors.white),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              label: "CANCEL",
                              onPressed: () {
                                setState(() {
                                  reasonController.clear();
                                });

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: reasonModify(
                                  state, context, reasonController)),
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

  SubmitButton reasonModify(LeaveFormState state, BuildContext context,
      TextEditingController reasonController) {
    return state.reason == null
        ? SubmitButton(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            label: "ADD",
            onPressed: state.isValidReason
                ? () {
                    context
                        .read<LeaveFormCubit>()
                        .submitReason(reasonController.text.trim());

                    Navigator.pop(context);
                    setState(() {
                      reasonController.clear();
                    });
                  }
                : null)
        : state.isValidReason
            ? SubmitButton(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                label: "EDIT",
                onPressed: () {
                  context
                      .read<LeaveFormCubit>()
                      .submitReason(reasonController.text.trim());

                  Navigator.pop(context);
                  setState(() {
                    reasonController.clear();
                  });
                })
            : SubmitButton(
                buttonColor: MaterialStateProperty.all(Colors.red),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                label: "REMOVE",
                onPressed: () {
                  context.read<LeaveFormCubit>().resetReason();
                  Navigator.pop(context);
                  setState(() {
                    reasonController.clear();
                  });
                });
  }
}
