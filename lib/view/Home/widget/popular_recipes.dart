// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/view/home/widget/rating_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularRecipes extends StatefulWidget {
  const PopularRecipes({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<PopularRecipes> createState() => _PopularRecipesState();
}

class _PopularRecipesState extends State<PopularRecipes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.58,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      widget.recipe.name,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // ratings
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.015,
                      ),
                      child: RatingStars(rating: widget.recipe.rating),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      top: MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            "https://foodie.sysco.com/wp-content/uploads/2019/07/MarcusMeansChefProfile_800x850.jpg"),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        widget.recipe.owner.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.035),
                      const Icon(
                        CupertinoIcons.time,
                        color: Colors.black,
                        size: 14,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.009),
                      Text(
                        widget.recipe.duration,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -26, // Adjust as needed
            right: 10, // Adjust as needed
            child: Container(
              decoration: BoxDecoration(
                color: tAccentColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(widget.recipe.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
