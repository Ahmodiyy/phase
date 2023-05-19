import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/constant.dart';
import 'package:phase/features/onboarding/presentation/OnboardingInfoWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  final double bottomSheetHeight = 150;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              bottom: bottomSheetHeight, top: 20, right: 20, left: 20),
          child: PageView(
            controller: pageController,
            children: const [
              OnboardingInfoWidget(
                imageUrl: 'images/contraction.png',
                title: 'Contraction',
                briefExplanation:
                    'This period is marked by low institutional volume.',
              ),
              OnboardingInfoWidget(
                imageUrl: 'images/expansion.png',
                title: 'Expansion',
                briefExplanation:
                    'Expansion can either be bullish or bearish depending on the price movement.',
              ),
              OnboardingInfoWidget(
                imageUrl: 'images/trend.png',
                title: 'Trend',
                briefExplanation:
                    'Trends can be long term, short term, upward, downward and even sideways',
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: backgroundColor,
          height: bottomSheetHeight,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: foregroundColor,
                      dotColor: Colors.black12,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Submit button pressed.');
                  },
                  child: const Text(
                    'Get started',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }
}
