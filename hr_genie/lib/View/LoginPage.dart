import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/SignInForm.dart';
import 'package:hr_genie/Components/CustomTextField.dart';
import 'package:hr_genie/cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/cubit/AuthCubit/AuthState.dart';

import '../cubit/AuthCubit/AuthState.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false, body: CustomFormState());
  }
}
