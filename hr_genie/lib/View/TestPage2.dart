// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
// import 'package:hr_genie/Model/DepartmentModel.dart';
// import 'package:hr_genie/Model/EmployeeModel.dart';

// class TestPage2 extends StatefulWidget {
//   const TestPage2({Key? key}) : super(key: key);

//   @override
//   _TestPage2State createState() => _TestPage2State();
// }

// class _TestPage2State extends State<TestPage2> {
//   @override
//   void initState() {
//     context.read<ApiServiceCubit>().fetchEmployees();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () async {
//             await context.read<ApiServiceCubit>().addEmployee(Employee(
//                 departmentId: "HR",
//                 employeeRole: "employee",
//                 firstName: "papa",
//                 lastName: "Raj",
//                 gender: "male",
//                 email: "dea@gmail.com",
//                 nric: "332142412412",
//                 position: 'Software Engineer'));
//             setState(() {
//               context.read<ApiServiceCubit>().fetchEmployees();
//             });
//           },
//           label: const Text("add department")),
//       body: FutureBuilder<List<Employee>>(
//         future: context.read<ApiServiceCubit>().fetchEmployees(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('An error has occurred!'),
//             );
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].firstName ?? ''),
//                   subtitle: Text(snapshot.data![index].email ?? ''),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
