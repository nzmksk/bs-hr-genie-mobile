import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomTextField.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFormState extends StatefulWidget {
  const CustomFormState({super.key});

  @override
  State<CustomFormState> createState() => _CustomFormStateState();
}

class _CustomFormStateState extends State<CustomFormState> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool _rememberMe = false;
  bool isValid = false;
  @override
  void initState() {
    context.read<AuthCubit>().loadUserEmailPassword();
    super.initState();
  }

  Future<String> _getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMeStatus = prefs.getString("");
    if (rememberMeStatus == null) {
      return "";
    }
    return rememberMeStatus;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
        } else if (state.status == AuthStatus.initial) {
          setState(() {});
        }
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
                hintText: "Your Working email",
                autofillHints: const [AutofillHints.email],
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
              InkWell(
                onTap: () {
                  AppRouter.router.push(
                      "${PAGES.login.screenPath}/${PAGES.forgotPassword.screenPath}");
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(240, 10, 20, 0),
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              SubmitButton(
                label: 'Login',
                margin: const EdgeInsets.fromLTRB(0, 200, 0, 40),
                onPressed: state.isNotNull
                    ? () {
                        context
                            .read<AuthCubit>()
                            .signIn(state.email, state.password, context);
                      }
                    : null,
              )
            ],
          )),
        );
      },
    );
  }
}
