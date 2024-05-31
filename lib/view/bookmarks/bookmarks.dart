// ignore_for_file: prefer_const_constructors

import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/search/widget/result.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookMarkState();
}

class _BookMarkState extends State<Bookmarks> {
  @override
  void initState() {
    super.initState();
    getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Rcipes',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75, // Adjust as needed
          ),
          itemCount: User.savedRecipes.length,
          itemBuilder: (context, index) {
            return ResultCard(recipe: User.savedRecipes[index]);
          },
        ),
      ),
    );
  }
}

Future<List<Recipe>> getBookmarks() async {
  return User.savedRecipes;
}
