import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/home/widget/fridge_slider.dart';
import 'package:bytechef/view/home/widget/home_bar.dart';
import 'package:bytechef/view/home/widget/recipe_recommendation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedFridgeItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          HomeBar(user: widget.user),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  "What's in your fridge today?",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          FridgeItems(
            onItemSelected: (selectedItem) {
              setState(() {
                selectedFridgeItem = selectedItem;
              });
            },
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Recipe>>(
            future: getRecommendedRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final recipes = snapshot.data ?? [];
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: recipes.map((recipe) {
                      return RecipeRecommendationCard(
                        recipeName: recipe.name,
                        recipeImage: recipe.imageUrl,
                        recipeRating: recipe.rating.toString(),
                        recipeDuration: recipe.duration,
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('New Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Recipe>> getRecommendedRecipes() async {
    if (selectedFridgeItem != null) {
      // If item is selected, get recipes based on ingredients
      return RecipeRepository.getRecipesByIngredient(selectedFridgeItem!);
    } else {
      // If no item selected, or no ingredients match, return first three recipes
      return RecipeRepository.getAllRecipes().take(3).toList();
    }
  }
}
