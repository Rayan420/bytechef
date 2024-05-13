import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/home/widget/fridge_slider.dart';
import 'package:bytechef/view/home/widget/home_bar.dart';
import 'package:bytechef/view/home/widget/popular_recipes.dart';
import 'package:bytechef/view/home/widget/recipe_recommendation.dart';
import 'package:bytechef/view/search/search.dart';
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
  List<String> filter = [];
  bool isSearchPressed = false;
  List<Recipe> recipesResult = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapped outside of a text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // conditionally show app bar
        appBar: isSearchPressed
            ? AppBar(
                backgroundColor: Color(0xFFECECEC),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.25),
                  child: const Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      isSearchPressed = false;
                      FocusScope.of(context).unfocus();
                    });
                  },
                ),
              )
            : null,
        backgroundColor: Color(0xFFECECEC),
        extendBody: true,
        body: ListView(
          children: [
            Column(
              children: [
                Visibility(
                    visible: isSearchPressed ? false : true,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045)),
                HomeBar(
                  user: widget.user,
                  onFiltersApplied: (selectedFilter) {
                    setState(() {
                      filter = selectedFilter;
                      print("Filter: $filter");
                    });
                  },
                  onSearchPressed: (bool) {
                    setState(() {
                      isSearchPressed = bool;
                      print("Search Pressed: $isSearchPressed");
                    });
                  },
                  showProfile: isSearchPressed ? false : true,
                  onSearch: (results) {
                    setState(() {
                      recipesResult = results;
                      print("recipesResult from search: $recipesResult");
                    });
                  },
                  onSearchQuery: (query) {
                    setState(() {
                      searchQuery = query;
                      print("Search Query: $searchQuery");
                    });
                  },
                ),
                Visibility(
                  visible: isSearchPressed,
                  child: Search(
                    recipes: recipesResult,
                    searchQuery: searchQuery,
                  ),
                ),
                Visibility(
                  visible: isSearchPressed ? false : true,
                  child: Column(
                    children: [
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
                      const SizedBox(height: 10),
                      FutureBuilder<List<Recipe>>(
                        future: getRecommendedRecipes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final recipes = snapshot.data ?? [];
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: recipes.map((recipe) {
                                  return RecipeRecommendationCard(
                                    recipe: recipe,
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.07,
                          top: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Popular Recipes',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.07,
                      ),
                      FutureBuilder<List<Recipe>>(
                        future: getPopularRecipes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final recipes = snapshot.data ?? [];
                            return SingleChildScrollView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: recipes.map((recipe) {
                                  return PopularRecipes(
                                    recipe: recipe!,
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Future<List<Recipe>> getPopularRecipes() async {
    return RecipeRepository.getPopularRecipes().toList();
  }
}
