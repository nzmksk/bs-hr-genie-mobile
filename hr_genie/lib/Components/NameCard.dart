import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CountLeaveCompo.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: 400,
      height: 200,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: ListTile(
                  title: const Text(
                    "Mark Wien",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Talent Acquisition",
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.indigo, // <-- Button color
                      foregroundColor: Colors.white, // <-- Splash color
                    ),
                    child: const Icon(Icons.add_rounded),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black54,
                indent: 20,
                endIndent: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountLeaveComponent(
                    title: 'Available',
                    count: 2,
                  ),
                  CountLeaveComponent(
                    title: 'Total',
                    count: 26,
                  ),
                  CountLeaveComponent(
                    title: 'Used',
                    count: 22,
                    countColor: Colors.red,
                  )
                ],
              )
            ],
          )),
    );
  }
}
