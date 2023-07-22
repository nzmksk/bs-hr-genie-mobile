import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';

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
    super.initState();
    getUserData(context);
  }

  Future<void> getUserData(BuildContext context) async {
    final accessToken = await CacheStore().getCache('access_token');
    if (accessToken != null) {
      context.read<ApiServiceCubit>().getLeaveQuota(accessToken);
      print("done fetch user data");
    }
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
        printYellow("State: ${state.status}");
        print(
            "UserData: ${state.userData?.firstName} ${state.userData?.lastName}");

        return SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                width: 200,
                height: 170,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          isThreeLine: true,
                          title: CircleAvatar(
                            backgroundColor: primaryBlue,
                            radius: 30,
                            child: Text(
                              state.userData?.firstName![0] ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  "$firstName",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.userData!.position ?? 'Not Stated',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              BlocBuilder<ApiServiceCubit, ApiServiceState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 150,
                          height: 85,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: primaryBlue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text("Available"),
                                  Text(
                                    truncatNum(
                                        state.leaveQuotaList?[0]!.quota ?? '0'),
                                    style: const TextStyle(fontSize: 35),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 150,
                          height: 85,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: cardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text("Used"),
                                  Text(
                                    truncatNum(
                                        state.leaveQuotaList?[0]!.usedLeave ??
                                            '0'),
                                    style: const TextStyle(
                                        fontSize: 35, color: subtitleTextColor),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
