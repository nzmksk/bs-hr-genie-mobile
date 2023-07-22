// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/TextField/CustomTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/UpdatePassword/UpdatePasswordCubit.dart';
import 'package:hr_genie/Controller/Cubit/UpdatePassword/UpdatePasswordState.dart';
import 'package:hr_genie/Controller/Services/StatusMessage.dart';
import 'package:hr_genie/Controller/Services/TextStyle.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:lottie/lottie.dart';

class PasswordUpdateForm extends StatefulWidget {
  const PasswordUpdateForm({
    super.key,
  });

  @override
  State<PasswordUpdateForm> createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm>
    with SingleTickerProviderStateMixin {
  TextEditingController repeatController = TextEditingController();
  bool isObscure = true;
  // late AnimationController animationController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
      listener: (context, state) {
        if (state.status == UpdatePasswordStatus.success) showSuccessDialog();
        if (state.status == UpdatePasswordStatus.loading) {
          printYellow('LOADING');
        }
        if (state.status == UpdatePasswordStatus.error) print("error");
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 780,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 50, 130, 50),
                        child: const Text(
                          "Welcome!",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: globalTextColor, fontSize: 50),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          "Please create a new password to replace the temporary password given.",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: globalTextColor, fontSize: 25),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: const Text(
                            "Choose a strong password, avoid reusing passwords. Remember it or use a secure password manager.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: instructionTextColor, fontSize: 13),
                          ),
                        ),
                      ),
                      PasswordField(
                        obscurePassword: isObscure,
                        onpress: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        onchanged: (value) {
                          if (value == "" || value.isEmpty) {
                            repeatController.clear();
                          }
                          // _textFieldFocusNode.requestFocus();
                          context
                              .read<UpdatePasswordCubit>()
                              .newPasswordChanged(value);
                        },
                        errorStyle: state.newPassValid
                            ? TextStyleStore().success()
                            : TextStyleStore().failed(),
                        errorText: state.newPassValid
                            ? null
                            : MSG.newPassword.errorMsg,
                        hintText: "New Password",
                      ),
                      PasswordField(
                        visibleToggle: false,
                        controller: repeatController,
                        onpress: () {},
                        obscurePassword: true,
                        enabled: state.newPassword != "" && state.newPassValid
                            ? true
                            : false,
                        hintText: "Confirm New Password",
                        onchanged: (value) {
                          context
                              .read<UpdatePasswordCubit>()
                              .repeatPasswordChanged(value);
                        },
                        errorStyle:
                            state.isMatched ? null : TextStyleStore().failed(),
                        errorText: state.isMatched
                            ? null
                            : state.repeatPassEmpty
                                ? null
                                : MSG.repeatPassword.errorMsg,
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      SubmitButton(
                          label: "Update",
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          onPressed: state.isNotEmpty && state.isMatched
                              ? () async {
                                  context.read<AuthCubit>().renewPassword(
                                      context, state.repeatPassword);
                                }
                              : null)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Padding(
                // color: Colors.red,
                padding: const EdgeInsets.all(10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/success.json',
                      animate: true,
                      repeat: false,
                      // controller: controller,
                      // onLoaded: (composition) {
                      //   controller.duration =
                      //       composition.duration;
                      //   controller.forward();
                      // },
                    ),
                    const Text(
                        'Your password update success!\n You will need to login again\n'),
                    SubmitButton(
                        margin: const EdgeInsets.all(10),
                        label: 'OK',
                        onPressed: () {
                          AppRouter.router.go(PAGES.login.screenPath);
                          Navigator.pop(context);
                        })
                  ],
                ),
              ));
        });
  }
}
