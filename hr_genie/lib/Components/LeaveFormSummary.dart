import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormSummary extends StatelessWidget {
  const LeaveFormSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveFormCubit, LeaveFormState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
                'Leave Type: ${state.leaveType == "initial" ? "No leave added" : state.leaveType}'),
            Text('Duration: ${state.duration ?? "No duration added"}'),
            Text('Single Date: ${state.startDate ?? "No date added"}'),
            Text('How many Day: ${state.dateRange?.length ?? "No date added"}'),
            Text('Reason: ${state.reason ?? "No reason added"}'),
          ],
        );
      },
    );
  }
}
