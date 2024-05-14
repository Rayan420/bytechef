import 'package:bytechef/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int maxRating;

  const RatingStars({super.key, required this.rating, this.maxRating = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        maxRating,
        (index) {
          if (index < rating) {
            return const Icon(
              Iconsax.star5,
              color: tAccentColor,
              size: 20,
            );
          } else {
            return const Icon(
              Icons.star_border,
              color: tAccentColor,
              size: 20,
            );
          }
        },
      ),
    );
  }
}
