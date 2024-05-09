// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:bytechef/view/Home/home.dart';
import 'package:bytechef/view/auth/auth.dart';
import 'package:bytechef/view/onboarding/onboardin_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/auth':
        return MaterialPageRoute(builder: (_) => Authentication());

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
