// ignore_for_file: deprecated_member_use

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/sizes.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/data/userrepo.dart';
import 'package:bytechef/view/auth/widget/auth_page_footer.dart';
import 'package:bytechef/view/auth/widget/form_header.dart';
import 'package:bytechef/view/auth/widget/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapped outside of a text field
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const FormHeaderWidget(
                      title: tLoginTitle,
                      subtitle: tLoginSubtitle,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: tFormHeight - 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(CupertinoIcons.mail_solid),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            MyTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                    if (obscurePassword) {
                                      iconPassword = CupertinoIcons.eye_fill;
                                    } else {
                                      iconPassword =
                                          CupertinoIcons.eye_slash_fill;
                                    }
                                  });
                                },
                                icon: Icon(iconPassword),
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/forgot-password');
                                  },
                                  child: const Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: tForgotPasswordTitle,
                                      style: TextStyle(
                                        color: tAccentColor,
                                      ),
                                    ),
                                  ]))),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            Visibility(
                              visible: !signInRequired,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        backgroundColor: tPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        // validate inputs
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            signInRequired = true;
                                          });
                                          // sign in user
                                          User.login(emailController.text,
                                                  passwordController.text)
                                              .then((value) {
                                            if (value == null) {
                                              setState(() {
                                                _errorMsg =
                                                    'Invalid email or password';
                                                signInRequired = false;
                                              });
                                            } else {
                                              print(
                                                  UserRepository.users.length);
                                              User.persistRegister(user: value);
                                              // Navigate to the home screen with the user object as an argument
                                              Navigator.popAndPushNamed(
                                                  context, '/home',
                                                  arguments: value);
                                            }
                                          });
                                        }
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            tLogin,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  AuthPageFooter(
                                    isDarkMode: isDarkMode,
                                    tAuthMethod: tSignInWith,
                                    tAlternative: tSignUp,
                                    route: '/signup',
                                    footerText: tDontHaveAnAccount,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: signInRequired,
                      child: const CircularProgressIndicator(
                        color: tPrimaryColor,
                        backgroundColor: tSecondaryColor,
                        semanticsLabel: "Signing In...",
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
