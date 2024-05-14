// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/recipe/recipe_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key, required this.recipesResult});
  final List<Recipe> recipesResult;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return widget.recipesResult.isEmpty
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Text('No recipes found'),
          )
        : Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Search Results',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75, // Adjust as needed
                  ),
                  itemCount: widget.recipesResult.length,
                  itemBuilder: (context, index) {
                    return ResultCard(recipe: widget.recipesResult[index]);
                  },
                ),
              ],
            ),
          );
  }
}

class ResultCard extends StatefulWidget {
  const ResultCard({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // add recipe to history
        User.addToSearchHistory(widget.recipe);
        // Navigate to recipe details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeView(recipe: widget.recipe),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
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
                    Icon(Iconsax.star5,
                        color: Colors.yellow.shade700, size: 20),
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
    );
  }
}
