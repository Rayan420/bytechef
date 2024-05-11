import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileRecipeCard extends StatelessWidget {
  const ProfileRecipeCard({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      width: MediaQuery.of(context).size.width * 0.48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            // round top border
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.48,
              height: MediaQuery.of(context).size.width * 0.38,
              child: Image.memory(
                recipe.image!, // Assuming the image is a File object
                fit: BoxFit.cover, // Adjusted fit to cover the container
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              recipe.name,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                                child: SizedBox(
                              width: 20,
                              child: Icon(
                                CupertinoIcons.eye_fill,
                                size: 16,
                                color: Colors.grey,
                              ),
                            )),
                            TextSpan(
                              text: recipe.views
                                  .toString(), // Replace with actual value
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: 18,
                ),
                onSelected: (String value) {
                  // Handle menu item selection here
                  if (value == 'review') {
                    // Implement review action
                  } else if (value == 'delete') {
                    RecipeRepository.deleteRecipe(recipe);
                    // Implement delete action
                  } else if (value == 'modify') {
                    // Implement modify action
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
