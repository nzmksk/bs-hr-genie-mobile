import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
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
    super.initState();
    getUserData(context);
  }

  Future<void> getUserData(BuildContext context) async {
    final accessToken = await CacheStore().getCache('access_token');
    if (accessToken != null) {
      context.read<ApiServiceCubit>().getLeaveQuota(accessToken!);
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
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: 400,
            height: 170,
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
                        String? annual = "${state.leaveQuotaList?[0]!.quota}";
                        // num? medical = state.leaveQuotaList?[1]!.quota ?? 0;
                        // num? parental = state.leaveQuotaList?[2]!.quota ?? 0;

                        num? total = num.parse(annual);
                        num? used = 0;
                        num? available = total - used;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CountLeaveComponent(
                                  title: 'Available',
                                  count: available,
                                  countColor: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: CountLeaveComponent(
                                  title: 'Total',
                                  count: total,
                                  countColor: globalTextColor,
                                ),
                              ),
                              Expanded(
                                child: CountLeaveComponent(
                                  title: 'Used',
                                  count: used,
                                  countColor: globalTextColor,
                                ),
                              )
                            ],
                          ),
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
