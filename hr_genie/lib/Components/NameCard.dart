import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: 400,
          height: 200,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: primaryBlue,
                      radius: 30,
                      child: Text("M"),
                    ),
                    title: Text(
                      state.userData?.firstName ?? "",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      state.userData?.position ?? "",
                      style: TextStyle(fontSize: 14, color: subtitleTextColor),
                    ),
                  ),
                  const Divider(
                    color: globalTextColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CountLeaveComponent(
                        title: 'Available',
                        count: 2,
                        countColor: Colors.red,
                      ),
                      CountLeaveComponent(
                        title: 'Total',
                        count: 26,
                        countColor: globalTextColor,
                      ),
                      CountLeaveComponent(
                        title: 'Used',
                        count: 22,
                        countColor: globalTextColor,
                      )
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
