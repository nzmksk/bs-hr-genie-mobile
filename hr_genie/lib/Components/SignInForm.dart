import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TextField/CustomTextField.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Services/StatusMessage.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:lottie/lottie.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm>
    with SingleTickerProviderStateMixin {
  bool isObscure = true;
  TextEditingController passwordController = TextEditingController();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    passwordController.clear();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //development variables area
    const bool autoFocus = false;
    //development variables area
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          showSnackBar(context, state.errorMessage!, Colors.red);
        } else if (state.status == AuthStatus.notLogged) {
        } else if (state.status == AuthStatus.loggedIn) {
          showSnackBar(
              context, "You're logged as ${state.email}", Colors.green);
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.notLogged ||
            state.status == AuthStatus.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        child: Image.asset(
                          "assets/logo.png",
                          // height: 200,
                          // width: 300,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 30,
                      left: 84,
                      child: Text(
                        "HR GENIE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      left: 116 - 20,
                      child: Text(
                        "Fulfilling wishes at work.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              EmailField(
                autoFocus: autoFocus,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Basic dialog title'),
                          content: const Text(
                            'A dialog is a type of modal window that\n'
                            'appears in front of app content to\n'
                            'provide critical information, or prompt\n'
                            'for a decision to be made.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Disable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Enable'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                hintText: "Email address",
                prefixIcon: const Icon(Icons.email_sharp),
                onchanged: (value) {
                  setState(() {
                    passwordController.clear();
                  });
                  context.read<AuthCubit>().emailChanged(value);
                },
                errorStyle: state.validEmail
                    ? null
                    : const TextStyle(color: Colors.red),
                errorText: state.validEmail
                    ? null
                    : state.email == "" || state.email.isEmpty
                        ? null
                        : MSG.invalidEmail.errorMsg,
                //need to put the Data exist error here
              ),
              PasswordField(
                controller: passwordController,
                enabled:
                    state.email == "" || state.email.isEmpty ? false : true,
                autoFocus: autoFocus,
                obscurePassword: isObscure,
                onpress: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                onchanged: (value) {
                  context.read<AuthCubit>().passwordChanged(value);
                },
                errorStyle:
                    state.validPass ? null : const TextStyle(color: Colors.red),
                errorText: state.validPass ? null : MSG.loginPassword.errorMsg,
                hintText: "Password",
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(200, 5, 0, 0),
                child: GestureDetector(
                    child: Text("Forgot Password?",
                        style: TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Colors.blue[200],
                            fontSize: 15)),
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.transparent,
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
                                      ),
                                      const Text(
                                          'Your password update success!\n You will need to login again\n'),
                                      SubmitButton(
                                          margin: const EdgeInsets.all(10),
                                          label: 'OK',
                                          onPressed: () =>
                                              Navigator.pop(context))
                                    ],
                                  ),
                                ));
                          });
                    }),
              ),
              SubmitButton(
                margin: const EdgeInsets.fromLTRB(0, 200, 0, 15),
                label: "Login",
                onPressed: state.isNotNull
                    ? () {
                        context
                            .read<AuthCubit>()
                            .signIn(state.email, state.password, context);
                        // context.read<ApiServiceCubit>().getMyLeaves();

                        passwordController.clear();
                      }
                    : null,
              ),
              const Text(
                "You need to type in your email and password to Login",
                style: TextStyle(fontSize: 12, color: instructionTextColor),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ));
        } else if (state.status == AuthStatus.loading) {
          printYellow("status: ${state.status}");
          return ShimmerLoading(screenName: PAGES.leave.screenName);
        } else {
          printYellow("no status: ${state.status}");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
