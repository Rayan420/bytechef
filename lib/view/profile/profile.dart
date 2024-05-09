import 'package:bytechef/view/profile/widget/profile_body.dart';
import 'package:bytechef/view/profile/widget/profile_header.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
        body: const Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 20), // Add some space between the header and body
            ProfileBody(),
          ],
        ));
  }
}
