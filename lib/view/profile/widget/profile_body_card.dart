// ignore_for_file: prefer_const_constructors

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileRecipeCard extends StatefulWidget {
  const ProfileRecipeCard(
      {super.key, required this.recipe, required this.owner});
  final Recipe recipe;
  final User owner;

  @override
  State<ProfileRecipeCard> createState() => _ProfileRecipeCardState();
}

class _ProfileRecipeCardState extends State<ProfileRecipeCard> {
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
              Visibility(
                visible: widget.recipe.owner.email == widget.owner.email,
                child: Positioned(
                  bottom: 7,
                  right: -1,
                  child: widget.recipe.owner.email == widget.owner.email
                      ? PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert_outlined,
                            size: 18,
                          ),
                          onSelected: (String value) {
                            // Handle menu item selection here
                            if (value == 'review') {
                              // Implement review action
                            } else if (value == 'delete') {
                              setState(() {
                                RecipeRepository.deleteRecipe(widget.recipe);
                                widget.owner.deleteRecipe(widget.recipe);
                              });
                              // Implement delete action
                            } else if (value == 'modify') {
                              // Implement modify action
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'review',
                              child: Text('Review'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'modify',
                              child: Text('Modify'),
                            ),
                          ],
                        )
                      : IconButton(
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
                ),
              ),
              Visibility(
                visible: !(widget.recipe.owner.email == widget.owner.email),
                child: Positioned(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
