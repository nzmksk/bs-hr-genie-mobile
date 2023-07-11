import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
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
        String? firstName = state.userData?.firstName;
        String? lastName = state.userData?.lastName;

        return SingleChildScrollView(
          child: Container(
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
                      leading: CircleAvatar(
                        backgroundColor: primaryBlue,
                        radius: 30,
                        child: Text(
                          state.userData?.firstName![0] ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ),
                      title: Text(
                        "$firstName $lastName",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        state.userData?.position ?? "",
                        style: const TextStyle(
                            fontSize: 14, color: subtitleTextColor),
                      ),
                    ),
                    const Divider(
                      color: globalTextColor,
                      indent: 20,
                      endIndent: 20,
                    ),
                    BlocBuilder<ApiServiceCubit, ApiServiceState>(
                      builder: (context, state) {
                        num? annual = state.leaveQuotaList![0]!.quota;
                        num? medical = state.leaveQuotaList![1]!.quota;
                        num? parental = state.leaveQuotaList![2]!.quota;

                        num? total = annual! + medical! + parental!;
                        num? used = 0;
                        num? available = total - used;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CountLeaveComponent(
                              title: 'Available',
                              count: available,
                              countColor: Colors.red,
                            ),
                            CountLeaveComponent(
                              title: 'Total',
                              count: total,
                              countColor: globalTextColor,
                            ),
                            CountLeaveComponent(
                              title: 'Used',
                              count: used,
                              countColor: globalTextColor,
                            )
                          ],
                        );
                      },
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
