import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';

class EmptyMyLeave extends StatelessWidget {
  const EmptyMyLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Nothing applied..",
            style: TextStyle(fontSize: 30, color: subtitleTextColor),
          ),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/apply.svg',
            width: 170,
            height: 170,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Apply for leave just at your finger tips!",
            style: TextStyle(color: instructionTextColor),
          ),
          SubmitButton(
            buttonColor: cardColor,
            label: 'Refresh',
            onPressed: () async {
              final accessToken = await CacheStore().getCache('access_token');
              await context.read<ApiServiceCubit>().getLeaveQuota(accessToken!);
              await context.read<ApiServiceCubit>().getMyLeaves(accessToken);

              context.read<AuthCubit>().fetchUserData();
              showCustomSnackBar(context, 'refreshed', cardColor);
            },
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          )
        ],
      ),
    );
  }
}
