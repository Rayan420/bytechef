import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/sizes.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:flutter/material.dart';

class AuthPageFooter extends StatelessWidget {
  const AuthPageFooter(
      {super.key,
      required this.isDarkMode,
      required this.tAuthMethod,
      required this.tAlternative,
      required this.route,
      required this.footerText});

  final bool isDarkMode;
  final String tAuthMethod;
  final String tAlternative;
  final String route;
  final String footerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 1,
                color: isDarkMode ? tWhiteColor : tBlackColor,
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: isDarkMode ? tWhiteColor : tBlackColor,
                    ),
                  ),
                  Container(
                    width: 50, // Adjust the width as needed
                    height: 1, // Adjust the height as needed
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                  ),
                  Text(
                    tAuthMethod,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Container(
                    width: 50, // Adjust the width as needed
                    height: 1, // Adjust the height as needed
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: isDarkMode ? tWhiteColor : tBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 1,
                color: isDarkMode ? tWhiteColor : tBlackColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: tFormHeight - 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black12, width: 1),
                backgroundColor: tWhiteColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Increased border radius
                ),
              ),
              child: const Image(
                image: AssetImage(tGoogleLogo),
                width: 20,
              ),
            ),
            const SizedBox(width: tFormHeight / 2),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black12, width: 1),
                backgroundColor: tWhiteColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Increased border radius
                ),
              ),
              child: const Image(
                image: AssetImage(tMetaLogo),
                width: 20,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, route);
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: footerText,
              // ignore: deprecated_member_use
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: tBlackColor),
            ),
            TextSpan(
              text: tAlternative,
              style: const TextStyle(
                color: tAccentColor,
              ),
            ),
          ])),
        )
      ],
    );
  }
}
