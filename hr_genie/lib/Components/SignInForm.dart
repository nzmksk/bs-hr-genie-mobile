import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Components/TextField/CustomTextField.dart';
import 'package:hr_genie/Constants/Color.dart';
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
  Widget build(BuildContext context) {
    //development variables area
    const bool autoFocus = false;
    //development variables area
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.status == AuthStatus.notLogged) {
        } else if (state.status == AuthStatus.loggedIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You're logged as ${state.email}"),
              backgroundColor: Colors.green,
            ),
          );
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
                  child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  "assets/logo.png",
                  height: 600,
                  width: 600,
                ),
              )),
              const Text(
                "HR GENIE",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Fulfilling wishes at work.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                hintText: "Your Working email",
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
                          "${PAGES.login.screenPath}/${PAGES.forgotPassword.screenPath}");
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
          print("status: ${state.status}");
          return const Center(child: CircularProgressIndicator());
        } else {
          print("status: ${state.status}");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
