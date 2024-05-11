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

    // Filter recipes where any ingredient contains the specified ingredient string
    return recipeRepo.where((recipe) {
      // Convert each ingredient to lowercase for case-insensitive matching
      final lowercaseIngredients =
          recipe.ingredients.map((ing) => ing.toLowerCase());

      // Check if any ingredient contains the specified ingredient string
      return lowercaseIngredients
          .any((ing) => ing.contains(lowercaseIngredient));
    }).toList();
  }

  // getall recipes from list
  static List<Recipe> getAllRecipes() {
    return recipeRepo;
  }
}
