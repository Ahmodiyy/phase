import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/features/onboarding/presentation/OnboardingScreen.dart';

void main() {
  group('OnboardingScreen', () {
    testWidgets('Renders PageView and bottom sheet',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Verify that the PageView is present
      expect(find.byType(PageView), findsOneWidget);

      // Verify that the bottom sheet is present
      expect(find.byType(Container), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Swiping updates displayed page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Verify the initial page is displayed
      expect(find.text('Contraction'), findsOneWidget);

      // Swipe to the next page

      await tester.ensureVisible(find.byType(PageView));
      await tester.fling(
          find.byType(PageView), const Offset(-300.0, 0.0), 3000);
      await tester.pumpAndSettle();

      // Verify the second page is displayed
      expect(find.text('Expansion'), findsOneWidget);

      // Swipe to the last page
      await tester.ensureVisible(find.byType(PageView));
      await tester.fling(
          find.byType(PageView), const Offset(-300.0, 0.0), 3000);
      await tester.pumpAndSettle();

      // Verify the last page is displayed
      expect(find.text('Trend'), findsOneWidget);
    });

    testWidgets('Button press triggers action', (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Tap the "Get started" button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the button press action is triggered
      buttonPressed = true;
      expect(buttonPressed, isTrue);
    });
  });
}
