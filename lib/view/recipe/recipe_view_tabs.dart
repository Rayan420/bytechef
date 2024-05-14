// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/view/recipe/recipe_view_information.dart';
import 'package:flutter/material.dart';

class RecipeViewTab extends StatelessWidget {
  const RecipeViewTab({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: tPrimaryColor,
              indicator: BoxDecoration(
                color: tPrimaryColor, // Customize indicator color
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: [
                const Tab(
                  text: 'Information',
                ),
                const Tab(text: 'Steps'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Description tab content
                RecipeViewInformation(recipe: recipe),
                // Steps tab content
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                    itemCount: recipe.steps.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: tPrimaryColor,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(recipe.steps[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
