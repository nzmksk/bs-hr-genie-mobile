import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      test();
    });
  }

  Future<void> test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    print("Runinansdjnawdni");
    context.watch<ApiServiceCubit>().getLeaveQuota(accessToken!);
    context.watch<AuthCubit>().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state.status == AuthStatus.loggedIn &&
            state.userData!.firstName == null) {}
      },
      builder: (context, state) {
        String? firstName = state.userData?.firstName;
        String? lastName = state.userData?.lastName;
        print("State: ${state.status}");
        print("UserData: ${state.userData?.firstName}");

        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: 400,
            height: 190,
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
                        num? annual = state.leaveQuotaList?[0]!.quota ?? 0;
                        num? medical = state.leaveQuotaList?[1]!.quota ?? 0;
                        num? parental = state.leaveQuotaList?[2]!.quota ?? 0;

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
