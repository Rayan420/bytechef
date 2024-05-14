// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/recipe/recipe_view_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class RecipeView extends StatefulWidget {
  RecipeView({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert_outlined,
              size: 18,
            ),
            onSelected: (String value) {
              // Handle menu item selection here
              if (value == 'Share') {
                // Implement review action
              } else if (value == 'Rate') {
                setState(() {});
                // Implement delete action
              } else if (value == 'modify') {
                // Implement modify action
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Share',
                child: Text('Share'),
              ),
              const PopupMenuItem<String>(
                value: 'Rate',
                child: Text('Rate'),
              ),
              const PopupMenuItem<String>(
                value: 'Review',
                child: Text('Review'),
              ),
              // if owner of the recipe
            ],
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              // pop out of the current screen
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Column(
              children: [
                // recipe image
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(widget.recipe.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: List<BoxShadow>.generate(
                                3,
                                (index) => BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 10,
                        right: 13,
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: tAccentColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: List<BoxShadow>.generate(
                              3,
                              (index) => BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ),
                            border: Border.all(
                              color: tAccentColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Iconsax.star5,
                                  color: tAccentColor, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.recipe.rating}/5",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 13,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              User.toggleSavedRecipe(widget.recipe);
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: tSecondaryColor.withOpacity(0.5),
                            fixedSize: const Size(30, 30),
                          ),
                          iconSize: 20,
                          icon: User.isRecipeSaved(widget.recipe)
                              ? const Icon(
                                  Iconsax.heart5,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Iconsax.heart5,
                                  color: Colors.white,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                // recipe name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.recipe.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // row with user detail and follow button
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://www.avenuecalgary.com/wp-content/uploads/ChefProfile-MichaelAllemeier.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipe.owner.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '@${widget.recipe.owner.name.replaceAll(' ', '')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // if the user is not the owner of the recipe
                    if (widget.recipe.owner != User.getCurrentUser())
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            User.toggleFollow(widget.recipe.owner.email);
                            print(User.following);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              User.isFollowing(widget.recipe.owner.email)
                                  ? tSecondaryColor
                                  : tPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          User.isFollowing(widget.recipe.owner.email)
                              ? 'Unfollow'
                              : 'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),

                    // if the user is the owner of the recipe
                    if (widget.recipe.owner == User.getCurrentUser())
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Implement modify action
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Modify',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                // recipe tabs
                Expanded(
                  child: RecipeViewTab(
                    recipe: widget.recipe,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 105,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Implement watch video action
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.play,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Watch Video',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
