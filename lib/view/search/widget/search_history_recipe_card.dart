// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bytechef/data/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchHistoryRecipeCard extends StatelessWidget {
  const SearchHistoryRecipeCard({super.key, required this.recipe, required this.date});
  final Recipe recipe;
  final int date;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the recipe details page
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.avenuecalgary.com/wp-content/uploads/ChefProfile-MichaelAllemeier.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipe Name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '4 days ago',
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
