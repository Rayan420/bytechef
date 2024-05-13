// ignore_for_file: prefer_const_constructors

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class RecipeRecommendationCard extends StatefulWidget {
  const RecipeRecommendationCard({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeRecommendationCard> createState() =>
      _RecipeRecommendationCardState();
}

class _RecipeRecommendationCardState extends State<RecipeRecommendationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to recipe details page
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(widget.recipe.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.recipe.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.eye,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.recipe.views.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text(
                        " · ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Icon(
                        Iconsax.clock,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        widget.recipe.duration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Iconsax.star5, color: tAccentColor, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.recipe.rating}/5",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(${widget.recipe.reviews.length} Reviews)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      User.toggleSavedRecipe(widget.recipe);
                    });
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(30, 30),
                  ),
                  iconSize: 20,
                  icon: User.isRecipeSaved(widget.recipe)
                      ? const Icon(
                          Iconsax.heart5,
                          color: Colors.red,
                        )
                      : const Icon(Iconsax.heart),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
