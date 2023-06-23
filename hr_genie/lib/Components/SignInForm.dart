import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/TextField/CustomTextField.dart';
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
        } else if (state.status == AuthStatus.initial) {}
      },
      builder: (context, state) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/logo.jpeg"),
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
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Disable'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
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
              errorStyle:
                  state.validEmail ? null : const TextStyle(color: Colors.red),
              errorText: state.validEmail
                  ? null
                  : state.email == "" || state.email.isEmpty
                      ? null
                      : MSG.loginEmail.errorMsg,
            ),
            PasswordField(
              controller: passwordController,
              enabled: state.email == "" ? false : true,
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
              errorText: state.validPass
                  ? null
                  : state.email == "" || state.email.isEmpty
                      ? null
                      : MSG.loginPassword.errorMsg,
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
            Container(
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 40),
              height: 46,
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: state.isNotNull
                      ? () {
                          context
                              .read<AuthCubit>()
                              .signIn(state.email, state.password, context);
                        }
                      : null,
                  child: const Text("Login")),
            )
          ],
        ));
      },
    );
  }
}
