import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phase/features/chart/domain/Coin.dart';
import 'package:phase/features/chart/presentation/CoinController.dart';
import 'package:phase/features/chart/presentation/crypto.dart'; // Replace with the actual import path

void main() {
  testWidgets('Crypto widget displays data correctly',
      (WidgetTester tester) async {
    // Build the Crypto widget wrapped in Providers for testing
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          coinControllerProvider.overrideWith(
            Provider<List<Coin>>((ref) => [
                  // Simulate some test data here
                  Coin(
                    id: 'bitcoin',
                    coinName: 'Bitcoin',
                    coinSymbol: 'BTC',
                    currentPriceInDollars: 50000,
                    priceChangePercentage: 2.5,
                    priceChange24h: 1500,
                    imageUrl: 'https://example.com/bitcoin.png',
                    coinPrice24h: 48500,
                  ),
                  // Add more test coins if needed
                ]) as CoinController Function(),
          ),
        ],
        child: const MaterialApp(
          home: Crypto(),
        ),
      ),
    );

    // Verify that the widget displays the coin's name
    expect(find.text('Bitcoin'), findsOneWidget);

    // Verify that the widget displays the coin's symbol
    expect(find.text('BTC'), findsOneWidget);

    // Verify that the widget displays the current price
    expect(find.text('\$50,000.00'), findsOneWidget);

    // You can add more verification tests for other UI elements

    // Example: Verify that the widget displays the refresh button
    expect(find.text('Refresh'), findsOneWidget);
  });
}
