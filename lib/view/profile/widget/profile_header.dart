import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/global/custom_button.dart';
import 'package:bytechef/view/profile/widget/profile_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.07,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children at the start (left)
          children: [
            Align(
                alignment: Alignment
                    .centerLeft, // Align the avatar in the center horizontally
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(
                        width: size.width *
                            0.04), // Add some space between the avatar and text
                    ProfileData(
                      label: 'Recipes',
                      value: user.recipes?.length.toString(),
                    ),
                    SizedBox(width: size.width * 0.04),
                    ProfileData(
                      label: 'Followers',
                      value: user.followers,
                    ),
                    SizedBox(width: size.width * 0.04),
                    ProfileData(
                      label: 'Following',
                      value: user.following,
                    ),
                  ],
                )),
            SizedBox(
                height: size.height *
                    0.01), // Add some space between the avatar and text
            Text(
              user.name[0].toUpperCase() + user.name.substring(1),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              // concat user name with @ and remove witespace
              '@${user.name.replaceAll(' ', '')}',
              textAlign: TextAlign.center,
            ),

            // Add some space between the text and the button
            SizedBox(height: size.height * 0.02),
            CustomButton(
              title: 'Manage Profile',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
