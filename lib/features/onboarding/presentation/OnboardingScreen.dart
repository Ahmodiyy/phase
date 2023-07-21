import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phase/constant.dart';
import 'package:phase/features/onboarding/presentation/CustomPageViewScrollPhysics.dart';
import 'package:phase/features/onboarding/presentation/OnboardingImageWidget.dart';
import 'package:phase/features/onboarding/presentation/OnboardingInfoWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController pageController;
  final double bottomSheetHeight = 150;
  double animValue = 0.0;
  double pageViewHalfPixel = 1.0;
  double currentOffset = 0.0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    pageController.addListener(() {
      pageController.position.addListener(() {
        pageViewHalfPixel = pageController.position.maxScrollExtent / 2;

        setState(() {
          currentOffset = pageController.position.pixels;
          debugPrint(pageViewHalfPixel.toString());
          double rateAnimeValue = 3 / pageViewHalfPixel;
          currentOffset < pageViewHalfPixel
              ? animValue = currentOffset * rateAnimeValue
              : animValue =
                  (currentOffset - pageViewHalfPixel) * rateAnimeValue;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              bottom: bottomSheetHeight, top: 20, right: 20, left: 20),
          child: Stack(children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(animValue),
              child: currentOffset < pageViewHalfPixel
                  ? OnboardingImageWidget(
                      imageUrl: animValue < 1.5
                          ? "images/contraction.png"
                          : "images/expansion.png")
                  : OnboardingImageWidget(
                      imageUrl: animValue < 1.5
                          ? "images/expansion_transform.png"
                          : "images/trend.png"),
            ),
            PageView(
              physics: const CustomPageViewScrollPhysics(),
              controller: pageController,
              children: const [
                OnboardingInfoWidget(
                  title: 'Contraction',
                  briefExplanation:
                      'This period is marked by low institutional volume, causing a range.',
                ),
                OnboardingInfoWidget(
                  title: 'Expansion',
                  briefExplanation:
                      'Increasing institutional volume, range taking highs and lows',
                ),
                OnboardingInfoWidget(
                  title: 'Trend',
                  briefExplanation:
                      'The market makes its moves to higher or lower prices',
                ),
              ],
            ),
          ]),
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
                  onPressed: () => context.push('/crypto'),
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
}
