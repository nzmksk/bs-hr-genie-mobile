import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/LeaveTabs.dart';
import 'package:hr_genie/Components/NameCard.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesCubit, RoutesCubitState>(
      builder: (context, state) {
        if (state.status == RouteStatus.initial) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                ProfileCard(),
                LeaveTabs(),
                // LeaveTab(),
              ],
            ),
          );
        } else if (state.status == RouteStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == RouteStatus.error) {
          return const Center(
            child: Text("ERROR"),
          );
        }

        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Error"), CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
