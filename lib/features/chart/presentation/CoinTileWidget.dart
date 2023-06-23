import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinTileWidget extends ConsumerWidget {
  final String imageUrl;
  final String coinName;
  final String coinSymbol;
  final String priceChange24h;
  final String priceChangePercentage;
  final String currentPriceInDollars;
  const CoinTileWidget({
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
    required this.priceChange24h,
    required this.priceChangePercentage,
    required this.currentPriceInDollars,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Image(
          image: NetworkImage(imageUrl),
          width: 40,
        ),
        Column(
          children: [
            AutoSizeText(
              coinName,
              style: Theme.of(context).textTheme.displayLarge,
              maxLines: 1,
            ),
            AutoSizeText(
              coinSymbol,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
            ),
          ],
        ),
        Container(
          width: 100,
        ),
        Column(
          children: [
            AutoSizeText(
              currentPriceInDollars,
              style: Theme.of(context).textTheme.displayLarge,
              maxLines: 1,
            ),
            Row(
              children: [
                AutoSizeText(
                  priceChange24h,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                ),
                AutoSizeText(
                  priceChangePercentage,
                  style: Theme.of(context).textTheme.displayLarge,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
