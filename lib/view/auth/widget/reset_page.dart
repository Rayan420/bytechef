// otp_row.dart
import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/sizes.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required String? errorMsg,
    required this.resetRequired,
    required this.isDarkMode,
    required this.otpValues,
    required this.widget,
    required this.onValueChanged,
    required this.text,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final bool resetRequired;
  final bool isDarkMode;
  final List<String> otpValues;
  final Widget widget;
  final VoidCallback onValueChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget,
            const SizedBox(height: tFormHeight - 20),
            Visibility(
              visible: !resetRequired,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                        backgroundColor: tPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onValueChanged,
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
