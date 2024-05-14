import 'package:bytechef/data/notification.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/userrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String password;
  String followersCount;
  String followingCount;
  List<Recipe> recipes = [];
  List<UserNotification> notifications = [];
  static List<Recipe> savedRecipes = [];
  static Map<DateTime, Recipe> searchHistory = {};
  static List<String> followers = [];
  static List<String> following = [];
  static User? currentUser; // Static variable to hold the current user

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.followersCount,
    required this.followingCount,
  });

  // Method to set the current user
  static void setCurrentUser(User user) {
    currentUser = user;
  }

  // Method to get the current user
  static User? getCurrentUser() {
    return currentUser;
  }

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

  // populate the followers and following list from json as args
  void populateFollowersAndFollowing(
      List<String> followersList, List<String> followingList) {
    print("Followers: $followersList");
    print("Following: $followingList");
    followers = followersList;
    following = followingList;
  }

  // follow a user
  static void followUser(String email) {
    following.add(email);
    // parse followercount to int and increment by 1 for the followed user and update the user repo
    UserRepository.users
        .firstWhere((user) => user.email == email)
        .followersCount = (int.parse(UserRepository.users
                .firstWhere((user) => user.email == email)
                .followersCount) +
            1)
        .toString();
  }

  // unfollow a user
  static void unfollowUser(String email) {
    following.remove(email);
    // parse followercount to int and decrement by 1 for the unfollowed user and update the user repo
    UserRepository.users
        .firstWhere((user) => user.email == email)
        .followersCount = (int.parse(UserRepository.users
                .firstWhere((user) => user.email == email)
                .followersCount) -
            1)
        .toString();
  }

  // from json
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        followersCount = json['followersCount'],
        followingCount = json['followingCount'];

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
        followersCount: followers,
        followingCount: following,
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
      prefs.setString('followers', user.followersCount);
      prefs.setString('following', user.followingCount);

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

  /// Load user data from device storage upon login
// Load user data from device storage upon login
  static Future<User?> login(String email, String password) async {
    if (UserRepository.users
        .any((user) => user.email == email && user.password == password)) {
      return UserRepository.users.firstWhere(
          (user) => user.email == email && user.password == password);
    }
    return null; // Login failed
  }

  // a method to first 3 most recent recipes in search history and the date searched
  static Map<DateTime, Recipe> getSearchHistory() {
    return searchHistory;
  }

  // Method to add a recipe to the search history based on the day it was searched
  static void addToSearchHistory(Recipe recipe) {
    DateTime now = DateTime.now();
    // Add the recipe to the search history map with the day as the key
    searchHistory[now] = recipe;
  }

  // isfollowing
  static bool isFollowing(String email) {
    return following.contains(email);
  }

  // isfollower
  static bool isFollower(String email) {
    return followers.contains(email);
  }

  // toggle follow
  static void toggleFollow(String email) {
    isFollowing(email) ? unfollowUser(email) : followUser(email);
  }
}
