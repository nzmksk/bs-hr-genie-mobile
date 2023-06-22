import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomTextField.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool _rememberMe = false;
  bool isValid = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
        } else if (state.status == AuthStatus.initial) {}
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/logo.jpeg"),
              CustomTextField(
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
                icon: const Icon(Icons.email_sharp),
                onchanged: (value) {
                  context.read<AuthCubit>().emailChanged(value);
                },
                errorStyle: state.validEmail
                    ? null
                    : const TextStyle(color: Colors.red),
                errorText: state.validEmail ? null : "Your input is not valid",
              ),
              PasswordField(
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
                errorText:
                    state.validPass ? null : "Your password is not valid!",
                hintText: "Password",
              ),
              CheckboxListTile(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = !_rememberMe;
                  });
                },
                title: const Text("Remember me"),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 2, 0),
                splashRadius: 20.0,
                enableFeedback: true,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 200, 0, 40),
                height: 46,
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
          )),
        );
      },
    );
  }
}
