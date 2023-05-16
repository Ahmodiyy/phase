import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/onboarding/presentation/OnboardingInfoWidget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 100),
            child: PageView(
              children: const [
                OnboardingInfoWidget(
                  imageUrl: 'images/contraction.png',
                  title: 'Contraction',
                  briefExplanation: 'kakjfaj',
                ),
                OnboardingInfoWidget(
                  imageUrl: 'images/expansion.png',
                  title: 'Expansion',
                  briefExplanation: 'kdjklkajk',
                ),
                OnboardingInfoWidget(
                  imageUrl: 'images/trend.png',
                  title: 'Trend',
                  briefExplanation: 'kfdklffja',
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 100,
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    debugPrint('Submit button pressed.');
                  },
                  child: const Text(
                    'Get started',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
