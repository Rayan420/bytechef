import 'package:bytechef/data/notification.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/userrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String followers;
  final String following;
  List<Recipe> recipes = [];
  List<UserNotification> notifications = [];
  static List<Recipe> savedRecipes = [];
  static Map<int, Recipe> searchHisotry = {};

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.followers,
    required this.following,
  });

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  void deleteRecipe(Recipe recipe) {
    recipes.remove(recipe);
  }

  void updateRecipe(Recipe oldRecipe, Recipe newRecipe) {
    recipes[recipes.indexWhere((recipe) => recipe.name == oldRecipe.name)] =
        newRecipe;
  }

  // method to check if a recipe is saved
  static bool isRecipeSaved(Recipe recipe) {
    return savedRecipes.contains(recipe);
  }

  // add recipe to saved recipe
  static void toggleSavedRecipe(Recipe recipe) {
    return isRecipeSaved(recipe)
        ? savedRecipes.remove(recipe)
        : savedRecipes.add(recipe);
  }

  // from json
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        followers = json['followers'],
        following = json['following'];

  // register user and save to user repo
  static Future<User?> register({
    required String name,
    required String email,
    required String password,
    required String followers,
    required String following,
  }) async {
    try {
      User user = User(
        name: name,
        email: email,
        password: password,
        followers: followers,
        following: following,
      );
      UserRepository.addUser(user);
      return user;
    } catch (e) {
      return null; // Registration failed
    }
  }

  // Save user data to device storage upon registration
  static Future<bool> persistRegister({
    required User user,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', user.name);
      prefs.setString('email', user.email);
      prefs.setString('password', user.password);
      prefs.setString('followers', user.followers);
      prefs.setString('following', user.following);

      return true; // Registration successful
    } catch (e) {
      return false; // Registration failed
    }
  }

  // add notification to user
  void addNotification(UserNotification notification) {
    notifications.add(notification);
  }

  // get unread notifications
  List<UserNotification> getUnreadNotifications() {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  // get read notifications
  List<UserNotification> getReadNotifications() {
    return notifications.where((notification) => notification.isRead).toList();
  }

  // Load user data from device storage upon login
  static Future<User?> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');
    if (email == storedEmail && password == storedPassword) {
      print(RecipeRepository.getRecipesByUser(storedEmail!));
      final user = User(
        name: prefs.getString('name')!,
        email: storedEmail,
        password: storedPassword!,
        followers: prefs.getString('followers')!,
        following: prefs.getString('following')!,
      );
      user.recipes = RecipeRepository.getRecipesByUser(storedEmail);
      UserRepository.addUser(user);
      return user;
    } else if (UserRepository.users
        .any((user) => user.email == email && user.password == password)) {
      return UserRepository.users.firstWhere(
          (user) => user.email == email && user.password == password);
    }
    return null; // Login failed
  }

  // a method to first 3 most recent recipes in search history and the date searched
  static Map<int, Recipe> getSearchHistory() {
    return searchHisotry;
  }
}
