
import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RecipeViewInformation extends StatelessWidget {
  const RecipeViewInformation({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // display recipe servings
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align left
                children: [
                  const Icon(
                    Iconsax.reserve4,
                    size: 20,
                    color: tPrimaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${recipe.serving}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: tPrimaryColor,
                    ),
                  ),
                ],
              ),
              // Spacer to push the next row to the right
              const Spacer(),
              // display recipe duration
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align right
                children: [
                  const Icon(
                    Iconsax.clock,
                    size: 20,
                    color: tPrimaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${recipe.duration}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: tPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 8.0),
          child: Text(
            'Description',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            recipe.description,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipe.ingredients.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // Display each ingredient in the list of ingredients for the recipe with and u bullet point
                '• ${recipe.ingredients[index]}',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
