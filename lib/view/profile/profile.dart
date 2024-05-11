import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/profile/widget/profile_body.dart';
import 'package:bytechef/view/profile/widget/profile_header.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            ProfileHeader(user: user),
            SizedBox(height: 20), // Add some space between the header and body
            ProfileBody(
              user: user,
            ),
          ],
        ));
  }
}
