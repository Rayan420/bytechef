// ignore_for_file: , prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/recipe.dart';
import 'package:bytechef/data/recipe_repo.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/home/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeBar extends StatefulWidget {
  const HomeBar(
      {super.key,
      required this.user,
      required this.onFiltersApplied,
      required this.onSearchPressed,
      required this.showProfile,
      required this.onSearch,
      required this.onSearchQuery});
  final User user;
  final Function(List<String>) onFiltersApplied;
  final Function(bool) onSearchPressed;
  final bool showProfile;
  final Function(List<Recipe>) onSearch;
  final Function(String) onSearchQuery;

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  List<String> selectedFilters = [];
  List<Recipe> results = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.showProfile,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://www.avenuecalgary.com/wp-content/uploads/ChefProfile-MichaelAllemeier.jpg'),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, 👋🏻',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      // user.name first letter is capitalized
                      widget.user.name[0].toUpperCase() +
                          widget.user.name.substring(1),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.search_normal_1, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onTap: () {
                              widget.onSearchPressed(true);
                            },
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  results =
                                      RecipeRepository.getRecipesBySearchQuery(
                                          value);
                                  widget.onSearch(results);
                                  widget.onSearchQuery(value);
                                } else {
                                  results = [];
                                  widget.onSearch(results);
                                  widget.onSearchQuery(value);
                                }
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for recipes',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    width: 10), // Spacer between search bar and filter icon
                Container(
                  decoration: BoxDecoration(
                    color: tPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // open bottom sheet

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return BottomSheetFilter(
                            onFiltersApplied: (selectedFilters) {
                              setState(() {
                                this.selectedFilters = selectedFilters;
                              });
                              // Handle the selected filters here
                              // Pass the selected filters to the parent widget
                              widget.onFiltersApplied(selectedFilters);
                            },
                            selectedFilters: selectedFilters,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Iconsax.filter5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
