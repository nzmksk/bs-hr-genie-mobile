import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/SignInForm.dart';
import 'package:hr_genie/Components/customTextField.dart';
import 'package:hr_genie/cubit/auth_cubit/auth_cubit.dart';
import 'package:hr_genie/cubit/auth_cubit/auth_state.dart';

import '../cubit/auth_cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false, body: CustomFormState());
  }
}
