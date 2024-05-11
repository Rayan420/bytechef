// ignore_for_file: prefer_const_constructors

import 'package:bytechef/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecipeRecommendationCard extends StatefulWidget {
  const RecipeRecommendationCard(
      {super.key,
      required this.recipeName,
      required this.recipeImage,
      required this.recipeRating,
      required this.recipeDuration});
  final String recipeName;
  final String recipeImage;
  final String recipeRating;
  final String recipeDuration;

  @override
  State<RecipeRecommendationCard> createState() =>
      _RecipeRecommendationCardState();
}

class _RecipeRecommendationCardState extends State<RecipeRecommendationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        // child is a recipe image, name and rating and duration
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              //add image here
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  widget.recipeImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.recipeName,
                  maxLines: 1, // Limit to a single line
                  overflow: TextOverflow
                      .ellipsis, // Display ellipsis when text overflows
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        color: tAccentColor,
                        size: 16,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        '(${widget.recipeRating})',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      const Icon(
                        CupertinoIcons.time,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        widget.recipeDuration + ' mins',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
