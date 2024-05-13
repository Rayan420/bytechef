// ignore_for_file: prefer_const_constructors

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/home/widget/recipe_recommendation.dart';
import 'package:bytechef/view/search/widget/search_history_recipe_card.dart';
import 'package:flutter/material.dart';

class SearchWelcome extends StatelessWidget {
  const SearchWelcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        Visibility(
          visible: User.searchHisotry.isNotEmpty,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: tPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        // get search history and the key which is the date
        FutureBuilder(
            future: getSearchHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.keys.map((key) {
                      return SearchHistoryRecipeCard(
                        recipe: snapshot.data![key]!,
                        date: key,
                      );
                    }).toList(),
                  ),
                );
              }
            }),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: TextStyle(
                  color: tPrimaryColor,
                ),
              ),
            ),
          ],
        ),
        FutureBuilder(
            future: getPopularRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: snapshot.data!.map((recipe) {
                      return RecipeRecommendationCard(
                        recipe: recipe,
                      );
                    }).toList(),
                  ),
                );
              }
            }),
      ],
    );
  }
}

Future<List<Recipe>> getPopularRecipes() async {
  return RecipeRepository.getMostSearchedRecipes();
}

Future<Map<int, Recipe>> getSearchHistory() async {
  return User.getSearchHistory();
}
