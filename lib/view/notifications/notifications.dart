import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/notifications/tab_pair.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Notifications',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold)),
        ),
        body: CustomTabBar(
          user: user,
        ));
  }
}
