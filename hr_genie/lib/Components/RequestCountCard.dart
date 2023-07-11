import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';

class RequestCountCard extends StatefulWidget {
  const RequestCountCard({super.key, this.onTap});
  final Function()? onTap;

  @override
  State<RequestCountCard> createState() => _RequestCountCardState();
}

class _RequestCountCardState extends State<RequestCountCard> {
  final TextStyle numberStyle = const TextStyle(fontSize: 30);
  final TextStyle redCount = const TextStyle(fontSize: 30, color: Colors.red);
  final TextStyle titleStyle = const TextStyle(fontSize: 15);
  late final num? total;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        // num? annual = state.leaveQuotaList?[0]!.quota;
        // num? medical = state.leaveQuotaList?[1]!.quota;
        // num? parental = state.leaveQuotaList?[2]!.quota;
        // setState(() {
        //   // total = annual;
        //   // print("total leave : $total");
        // });

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // padding: const EdgeInsets.all(8),
          width: 400,
          height: 100,
          child: InkWell(
            customBorder:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: widget.onTap,
            child: Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RequestIndicator(
                    titleStyle: titleStyle,
                    numberStyle: numberStyle,
                    count: 10,
                    title: 'Total',
                  ),
                  RequestIndicator(
                    titleStyle: titleStyle,
                    numberStyle: numberStyle,
                    count: 2,
                    title: 'Approved',
                  ),
                  RequestIndicator(
                    titleStyle: titleStyle,
                    numberStyle: numberStyle,
                    count: 1,
                    title: 'Rejected',
                  ),
                  RequestIndicator(
                    titleStyle: titleStyle,
                    numberStyle: redCount,
                    count: 7,
                    title: 'Pending',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RequestIndicator extends StatelessWidget {
  const RequestIndicator({
    super.key,
    required this.titleStyle,
    required this.numberStyle,
    required this.title,
    required this.count,
  });

  final TextStyle titleStyle;
  final TextStyle numberStyle;
  final String title;
  final num count;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "$count",
          style: numberStyle,
        )
      ],
    );
  }
}
