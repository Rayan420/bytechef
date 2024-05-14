import 'dart:convert';

import 'package:bytechef/config/routes.dart';
import 'package:bytechef/config/shared_preference_config.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/data/userrepo.dart';
import 'package:bytechef/view/auth/login.dart';
import 'package:bytechef/view/onboarding/onboardin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // intialize shared preferences

  await SharedPreferencesConfig.initialize();
  if (kDebugMode) {
    print(SharedPreferencesConfig.getWelcome("loadWelcome"));
  }
  await loadJson();

  runApp(const MainApp());
}

// extract the user data from the json file and the recipes nested in user data create a user object and add it to the user repository and add the recipes to the recipe repository
Future<void> loadJson() async {
  String data = await rootBundle.loadString('assets/recipes.json');
  var jsonResult = json.decode(data);

  for (var userData in jsonResult) {
    var userJson = userData['user'];
    User newUser = User(
      name: userJson['name'],
      email: userJson['email'],
      password: userJson['password'],
      followersCount: userJson['followersCount'],
      followingCount: userJson['followingCount'],
    )..populateFollowersAndFollowing(List<String>.from(userJson['followers']),
        List<String>.from(userJson['following']));

    for (var recipe in userJson['recipes']) {
      Recipe newRecipe = Recipe(
        name: recipe['name'],
        duration: recipe['duration'],
        serving: recipe['serving'],
        description: recipe['description'],
        rating: recipe['rating'],
        views: recipe['views'],
        ingredients: List<String>.from(recipe['ingredients']),
        steps: List<String>.from(recipe['steps']),
        owner: newUser,
        video: recipe['video'], // Handling null case
        videoUrl: recipe['videoUrl'],
        imageUrl: recipe['imageUrl'],
        searchCount: recipe['searchCount'],
        image: recipe['image'],
        category: List<String>.from(recipe['category']),
      );

      newUser.addRecipe(newRecipe);
      RecipeRepository.addRecipe(newRecipe);
    }

    UserRepository.addUser(newUser);
  }
  if (kDebugMode) {
    print(UserRepository.users.length);
  }
  if (kDebugMode) {
    print(RecipeRepository.recipeRepo.length);
  }
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
