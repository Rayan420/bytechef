import 'package:bytechef/view/onboarding/widget/onboarding_widget_last.dart';
import 'package:flutter/material.dart';
import 'package:bytechef/config/shared_preference_config.dart';
import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/constants/strings.dart';
import 'package:bytechef/view/onboarding/model/onboard_model.dart';
import 'package:bytechef/view/onboarding/widget/on_boarding_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingWidget(
        model: OnBoardingModel(
          image: tOnBoardingImage1,
          title: tOnBoardingTitle1,
          subtitle: tOnBoardingSubtitle1,
          bgColor: tOnBoardingPageColor,
          height: size.height,
        ),
      ),
      OnBoardingWidget(
        model: OnBoardingModel(
          image: tOnBoardingImage2,
          title: tOnBoardingTitle2,
          subtitle: tOnBoardingSubtitle2,
          bgColor: tOnBoardingPageColor,
          height: size.height,
        ),
      ),
      OnBoardingWidgetLast(
        model: OnBoardingModel(
          image: tOnBoardingImage3,
          title: tOnBoardingTitle3,
          subtitle: tOnBoardingSubtitle3,
          bgColor: tOnBoardingPageColor,
          height: size.height,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            liquidController: controller,
            onPageChangeCallback: onChangedCallBack,
            pages: pages,
            slideIconWidget: currentPage == pages.length - 1
                ? const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
            enableSideReveal: true,
            fullTransitionValue: 1000,
          ),
          Positioned(
            bottom: 20,
            child: AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: tPrimaryColor,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            child: MaterialButton(
              onPressed: () {
                if (currentPage < pages.length - 1) {
                  controller.animateToPage(
                    page: currentPage + 1,
                    duration: 500,
                  );
                } else {
                  SharedPreferencesConfig.saveWelcome("loadWelcome", false);
                  print(SharedPreferencesConfig.getWelcome("loadWelcome"));
                  Navigator.popAndPushNamed(context, "/auth");
                }
              },
              color: tPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: currentPage < pages.length - 1
                  ? const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  : const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          Visibility(
            visible: currentPage < pages.length - 1,
            child: Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  controller.jumpToPage(page: pages.length - 1);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tGreyColors,
                  ),
                  child: Text(
                    currentPage < pages.length - 1 ? 'Skip' : '',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onChangedCallBack(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
