import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingInfoWidget extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String briefExplanation;

  const OnboardingInfoWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.briefExplanation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(imageUrl),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge,
                )),
                const Flexible(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Flexible(
                    child: Text(
                  briefExplanation,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
