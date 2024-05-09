import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/global/custom_button.dart';
import 'package:bytechef/view/profile/widget/profile_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key});

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
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(
                        width: size.width *
                            0.04), // Add some space between the avatar and text
                    const ProfileData(
                      label: 'Recipes',
                      value: '20',
                    ),
                    SizedBox(width: size.width * 0.04),
                    const ProfileData(
                      label: 'Followers',
                      value: '1200',
                    ),
                    SizedBox(width: size.width * 0.04),
                    const ProfileData(
                      label: 'Following',
                      value: '200',
                    ),
                  ],
                )),
            SizedBox(
                height: size.height *
                    0.01), // Add some space between the avatar and text
            const Text(
              'Tasya Aulianza ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              '@tasyaaauz',
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
