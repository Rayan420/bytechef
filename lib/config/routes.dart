// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:bytechef/global/bottom_nav_bar.dart';
import 'package:bytechef/view/auth/auth.dart';
import 'package:bytechef/view/auth/forgot_password.dart';
import 'package:bytechef/view/auth/login.dart';
import 'package:bytechef/view/auth/signup.dart';
import 'package:bytechef/view/onboarding/onboardin_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => NavBar());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/auth':
        return MaterialPageRoute(builder: (_) => Authentication());
      case '/login':
        return MaterialPageRoute(builder: (_) => LogIn());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
