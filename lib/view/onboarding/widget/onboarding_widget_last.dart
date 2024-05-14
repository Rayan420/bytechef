import 'package:bytechef/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:bytechef/view/onboarding/model/onboard_model.dart';

class OnBoardingWidgetLast extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingWidgetLast({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
            ]),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.dstATop,
              ),
              image: const AssetImage('assets/images/onboarding3.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Image(
                      image: AssetImage('assets/images/chef.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: const Text(
                      tOnBoarding3SubTitle2,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    model.title,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    model.subtitle,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
