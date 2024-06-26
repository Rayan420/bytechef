// ignore_for_file: deprecated_member_use, unused_field

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/sizes.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/auth/widget/auth_page_footer.dart';
import 'package:bytechef/view/auth/widget/form_header.dart';
import 'package:bytechef/view/auth/widget/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;
  double passwordStrength = 0.0;
  String _error = '';
  bool _acceptTerms = false;

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
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/login");
              },
            ),
          ),
          body: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  children: [
                    const FormHeaderWidget(
                      title: tsignUpTitle,
                      subtitle: tsignUpSubtitle,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: tFormHeight - 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: tFormHeight - 20),
                            MyTextField(
                              controller: userNameController,
                              hintText: "Enter Name",
                              prefixIcon:
                                  const Icon(CupertinoIcons.person_fill),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            MyTextField(
                              controller: emailController,
                              hintText: 'Enter email',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(CupertinoIcons.mail_solid),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                    .hasMatch(val)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            MyTextField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: 'Password',
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              onChanged: (val) {
                                setState(() {
                                  passwordStrength =
                                      estimatePasswordStrength(val!);
                                });
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                    if (obscurePassword) {
                                      iconPassword = CupertinoIcons.eye;
                                    } else {
                                      iconPassword =
                                          CupertinoIcons.eye_slash_fill;
                                    }
                                  });
                                },
                                icon: Icon(iconPassword),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                } else if (passwordStrength < 0.3) {
                                  return 'Weak password. Include uppercase, lowercase, and minimum 8 characters.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: LinearProgressIndicator(
                                value: passwordStrength,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getPasswordStrengthColor(passwordStrength),
                                ),
                              ),
                            ),
                            CheckboxListTile(
                              activeColor: tAccentColor,
                              checkColor: tWhiteColor,
                              side: const BorderSide(color: tAccentColor),
                              title: const Text(
                                "Accept Terms & Conditions",
                                style: TextStyle(
                                  color: tAccentColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              value: _acceptTerms,
                              onChanged: (newValue) {
                                setState(() {
                                  _acceptTerms = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                              contentPadding: EdgeInsets
                                  .zero, // Adjust this value as needed
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            Visibility(
                              visible: !signUpRequired,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              signUpRequired = true;
                                            });

                                            User.register(
                                                    email: emailController.text,
                                                    name:
                                                        userNameController.text,
                                                    followers: '0',
                                                    following: '0',
                                                    password:
                                                        passwordController.text)
                                                .then((value) {
                                              User.persistRegister(user: value!)
                                                  .then((value) {
                                                setState(() {
                                                  signUpRequired = false;
                                                });
                                                if (value) {
                                                  // Navigate to the home screen or show a success message
                                                  Navigator.popAndPushNamed(
                                                      context, '/home',
                                                      arguments: value);
                                                } else {
                                                  // Show an error message to the user
                                                  setState(() {
                                                    _error =
                                                        'Registration failed. Please try again.';
                                                  });
                                                }
                                              });
                                              setState(() {
                                                signUpRequired = false;
                                              });

                                              // Navigate to the home screen or show a success message
                                              Navigator.popAndPushNamed(
                                                  context, '/home',
                                                  arguments: value);
                                            });
                                          }
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              tSignUp,
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
                                        )),
                                  ),
                                  const SizedBox(height: 30),
                                  AuthPageFooter(
                                    isDarkMode: isDarkMode,
                                    tAuthMethod: tSignUpWith,
                                    tAlternative: tLogin,
                                    route: '/login',
                                    footerText: tAlreadyHaveAnAccount,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: signUpRequired,
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

Color _getPasswordStrengthColor(double strength) {
  if (strength > 0.7) {
    return Colors.green;
  } else if (strength > 0.4) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
