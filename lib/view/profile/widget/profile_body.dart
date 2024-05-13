import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/profile/widget/profile_body_card.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 5, // Spacing between columns
      ),
      itemCount: widget.user.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.user.recipes[index];
        return ProfileRecipeCard(recipe: recipe, owner: widget.user);
      },
    );
  }
}
