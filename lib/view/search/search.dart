// ignore_for_file: prefer_const_constructors

import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/view/search/widget/result.dart';
import 'package:bytechef/view/search/widget/search_welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.recipes, required this.searchQuery});

  final List<Recipe> recipes;
  final String searchQuery;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08),
        child: widget.searchQuery.isEmpty && widget.recipes.isEmpty
            ? SearchWelcome()
            : SearchResult(
                recipesResult: widget.recipes,
              ));
  }
}
