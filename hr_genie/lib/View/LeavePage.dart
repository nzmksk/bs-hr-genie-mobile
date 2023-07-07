import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/LeaveTabs.dart';
import 'package:hr_genie/Components/NameCard.dart';
import 'package:hr_genie/Components/RequestCountCard.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesCubit, RoutesCubitState>(
      builder: (context, state) {
        if (state.status == RouteStatus.initial) {
          return SafeArea(
            child: Scaffold(
              floatingActionButton: RawMaterialButton(
                onPressed: () {
                  context.read<RoutesCubit>().goToApplyLeave();
                },
                // elevation: 2.0,
                fillColor: primaryBlue,
                padding: const EdgeInsets.all(6.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  size: 35.0,
                ),
              ),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCard(),
                  RequestCountCard(),
                  LeaveTabs(),
                ],
              ),
            ),
          );
        } else if (state.status == RouteStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == RouteStatus.error) {
          return Center(
            child: Text("ERROR: ${state.status}"),
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
