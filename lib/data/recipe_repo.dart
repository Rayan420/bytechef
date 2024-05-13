import 'dart:typed_data';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static List<Recipe> recipeRepo = List.empty(growable: true);

// get recipe repo length
  static int getRecipeRepoLength() {
    return recipeRepo.length;
  }
  // Other methods...

  // add recipe to the repository
  static void addRecipe(Recipe recipe) {
    recipeRepo.add(recipe);
  }

  // get all recipes from the repository
  static List<Recipe> getRecipes() {
    return recipeRepo;
  }

  // get a recipe by its name
  static Recipe getRecipeByName(String name) {
    return recipeRepo.firstWhere((recipe) => recipe.name == name);
  }

  // get reccipes of a user
  static List<Recipe> getRecipesByUser(String email) {
    return recipeRepo.where((recipe) => recipe.owner.email == email).toList();
  }

  // delete recipe from the repository
  static void deleteRecipe(Recipe recipe) {
    recipeRepo.remove(recipe);
  }

  // get recommended recipes by ingredients from the list of recipes
  static List<Recipe> getRecipesByIngredient(String ingredient) {
    // Convert the ingredient to lowercase for case-insensitive matching
    final lowercaseIngredient = ingredient.toLowerCase();

    // Filter recipes where any ingredient contains the specified ingredient string else return first 4 recipes
    if (recipeRepo.any((recipe) => recipe.ingredients.any((ingredient) =>
        ingredient.toLowerCase().contains(lowercaseIngredient)))) {
      return recipeRepo
          .where((recipe) => recipe.ingredients.any((ingredient) =>
              ingredient.toLowerCase().contains(lowercaseIngredient)))
          .toList();
    } else
      return recipeRepo.sublist(0, 4);

    // return recipeRepo.sublist(0, 4);
  }

  // method to return list of recipes by search query
  static List<Recipe> getRecipesBySearchQuery(String query) {
    // Convert the query to lowercase for case-insensitive matching
    final lowercaseQuery = query.toLowerCase();

    // Filter recipes where the name contains the specified query string
    return recipeRepo
        .where((recipe) => recipe.name.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // getall recipes from list
  static List<Recipe> getAllRecipes() {
    return recipeRepo;
  }

  // get popular recipes with 4.5 rating and above order by rating
  static List<Recipe> getPopularRecipes() {
    return recipeRepo.where((recipe) => recipe.rating >= 4.5).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }

  // method to get most searched recipes
  static List<Recipe> getMostSearchedRecipes() {
    return recipeRepo.where((recipe) => recipe.searchCount > 0).toList()
      ..sort((a, b) => b.searchCount.compareTo(a.searchCount));
  }

  // Method to filter recipes by a list of filters
  static List<Recipe> filterRecipes(List<String> filters) {
    // Filter recipes by the filters passed in the argument
    List<Recipe> filteredRecipes = recipeRepo.where((recipe) {
      // Check if the recipe matches the time filter
      if (_matchesTimeFilter(recipe, filters)) {
        return true;
      }
      return false;
    }).toList();

    // Filter recipes by the rating filter
    filteredRecipes = filteredRecipes.where((recipe) {
      // Round the recipe rating to the nearest whole number
      int roundedRating = recipe.rating.round();
      // Check if the rounded rating matches the rating filter
      return filters.contains(roundedRating.toString());
    }).toList();
    print("filteredRecipes: $filteredRecipes");

    return filteredRecipes;
  }

  // Function to check if the recipe matches the time filter
  // Function to check if the recipe matches the time filter
  static bool _matchesTimeFilter(Recipe recipe, List<String> filters) {
    String duration = recipe.duration.toLowerCase();
    if (duration.contains('min')) {
      double minutes = double.parse(duration.split(' ')[0]);
      if (minutes <= 15 && filters.contains('Fastest')) {
        return true;
      } else if (minutes > 15 && minutes < 45 && filters.contains('Medium')) {
        return true;
      } else if (minutes >= 45 && filters.contains('Slowest')) {
        return true;
      }
    } else if (duration.contains('hour')) {
      if (filters.contains('Slowest')) {
        return true;
      }
    }
    return false;
  }
}
