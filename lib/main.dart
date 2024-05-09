import 'package:bytechef/config/routes.dart';
import 'package:bytechef/config/shared_preference_config.dart';
import 'package:bytechef/view/auth/login.dart';
import 'package:bytechef/view/onboarding/onboardin_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // intialize shared preferences

  await SharedPreferencesConfig.initialize();
  print(SharedPreferencesConfig.getWelcome("loadWelcome"));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: SharedPreferencesConfig.getWelcome("loadWelcome") == null ||
              SharedPreferencesConfig.getWelcome("loadWelcome") == true
          ? const OnBoardingScreen()
          : const LogIn(),
    );
  }
}
