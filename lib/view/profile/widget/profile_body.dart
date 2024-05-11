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
        crossAxisSpacing: 10, // Spacing between columns
        mainAxisSpacing: 10, // Spacing between rows
        childAspectRatio: 0.8, // Aspect ratio of each card
      ),
      itemCount: widget.user.recipes?.length ?? 0,
      itemBuilder: (context, index) {
        final recipe = widget.user.recipes![index];
        return ProfileRecipeCard(recipe: recipe);
      },
    );
  }
}
