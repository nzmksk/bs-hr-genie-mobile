import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/SubmitButton.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/logo.jpeg'), // Replace with your own image asset
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Software Engineer', // Replace with the user's occupation
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle:
                  Text('johndoe@example.com'), // Replace with the user's email
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text(
                  '+1 123-456-7890'), // Replace with the user's phone number
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle:
                  Text('New York, USA'), // Replace with the user's location
            ),
            const SizedBox(
              height: 30,
            ),
            SubmitButton(
                label: "Log Out",
                onPressed: () {
                  context.read<AuthCubit>().signOut(context);
                  AppRouter.router.go(PAGES.login.screenPath);
                })
          ],
        ),
      ),
    );
  }
}
