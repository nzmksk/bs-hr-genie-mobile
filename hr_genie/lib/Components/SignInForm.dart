import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TextField/CustomTextField.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Services/StatusMessage.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool isObscure = true;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.clear();
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
                    FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                      child: Image.asset(
                        "assets/logo.png",
                        // height: 200,
                        // width: 300,
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
                    onTap: () {
                      AppRouter.router.go(
                          "${PAGES.login.screenPath}/${PAGES.passwordUpdate.screenPath}");
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
