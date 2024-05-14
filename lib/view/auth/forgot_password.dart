// ignore_for_file: unused_local_variable

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/sizes.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/view/auth/widget/form_header.dart';
import 'package:bytechef/view/auth/widget/my_text_field.dart';
import 'package:bytechef/view/auth/widget/reset_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _resetFormKey = GlobalKey<FormState>(); // Unique key for reset form
  final _otpFormKey = GlobalKey<FormState>(); // Unique key for OTP form
  final _newPasswordFormKey =
      GlobalKey<FormState>(); // Unique key for new password form
  String? _errorMsg;
  bool resetRequired = false;
  bool otpRequired = false;
  bool confirmRequired = false;
  bool resetPage = true;
  bool otpPage = false;
  bool confirmPage = false;
  List<String> otpValues = List.filled(6, '');
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  double passwordStrength = 0.0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;

    final isDarkMode = brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapped outside of a text field
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (resetPage)
                      const FormHeaderWidget(
                        title: tForgotPasswordTitle,
                        subtitle: tForgotPasswordSubtitle,
                      ),
                    if (otpPage)
                      const FormHeaderWidget(
                        title: tVerifyOtpTitle,
                        subtitle: tVerifyOtpSubtitle,
                      ),
                    if (confirmPage)
                      const FormHeaderWidget(
                        title: tNewPasswordTitle,
                        subtitle: tNewPasswordSubtitle,
                      ),
                    const SizedBox(height: 20),
                    if (resetPage)
                      ResetPage(
                        formKey: _resetFormKey,
                        emailController: emailController,
                        errorMsg: _errorMsg,
                        resetRequired: resetRequired,
                        isDarkMode: isDarkMode,
                        otpValues: otpValues,
                        widget: MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(CupertinoIcons.mail_solid),
                          errorMsg: _errorMsg,
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
                        onValueChanged: () {},
                        text: tSendLink,
                      ),
                    if (otpPage)
                      ResetPage(
                        formKey: _otpFormKey,
                        emailController: emailController,
                        errorMsg: _errorMsg,
                        resetRequired: resetRequired,
                        isDarkMode: isDarkMode,
                        otpValues: otpValues,
                        widget: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 6; i++)
                                textFieldOTP(index: i),
                            ],
                          ),
                        ),
                        text: tVerify,
                        onValueChanged: () {
                          bool isOTPComplete =
                              otpValues.every((value) => value.isNotEmpty);
                        },
                      ),
                    if (confirmPage)
                      ResetPage(
                        formKey: _newPasswordFormKey,
                        emailController: emailController,
                        errorMsg: _errorMsg,
                        resetRequired: resetRequired,
                        isDarkMode: isDarkMode,
                        otpValues: otpValues,
                        widget: MyTextField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                          onChanged: (val) {
                            setState(() {
                              passwordStrength = estimatePasswordStrength(val!);
                            });
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                                if (obscurePassword) {
                                  iconPassword = CupertinoIcons.eye_fill;
                                } else {
                                  iconPassword = CupertinoIcons.eye_slash_fill;
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
                        onValueChanged: () {},
                        text: tNewPassword,
                      ),
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
                    Visibility(
                      visible: resetRequired || otpRequired,
                      child: const CircularProgressIndicator(
                        color: tPrimaryColor,
                        backgroundColor: tSecondaryColor,
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

  Widget textFieldOTP({required int index}) {
    return Expanded(
      child: Container(
        height: 85,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            onChanged: (value) {
              if (value.isNotEmpty && index <= otpValues.length - 1) {
                setState(() {
                  otpValues[index] = value;
                });
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && index > 0) {
                setState(() {
                  otpValues[index] = value;
                });
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12),
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
