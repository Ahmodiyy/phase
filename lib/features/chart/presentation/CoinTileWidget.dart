import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinTileWidget extends ConsumerWidget {
  final String imageUrl;
  final String coinName;
  final String coinSymbol;
  final dynamic priceChange24h;
  final dynamic priceChangePercentage;
  final dynamic currentPriceInDollars;
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: NetworkImage(imageUrl),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coinName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displaySmall,
                    maxLines: 1,
                  ),
                  Text(
                    coinSymbol.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 15),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Container(),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$$currentPriceInDollars',
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          priceChange24h.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          priceChangePercentage.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
