import 'package:flutter/material.dart';
import 'package:bytechef/view/onboarding/model/onboard_model.dart';

class OnBoardingWidgetLast extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingWidgetLast({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/onboarding3.jpg'),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.6), // Adjust opacity for desired effect
                blurRadius: 1.0, // Adjust blur for softness
                spreadRadius: 0, // Spread radius zero to make it linear
                offset: Offset(0, 1), // Move shadow vertically downwards
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    model.subtitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned.fill(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
