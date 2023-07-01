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
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        coinName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                        maxLines: 1,
                      ),
                    ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$$currentPriceInDollars',
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            double.tryParse(priceChange24h.toString())!
                                .toStringAsFixed(2)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            double.tryParse(priceChangePercentage.toString())!
                                .toStringAsFixed(2)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: double.tryParse(
                                        priceChangePercentage.toString())!
                                    .isNegative
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
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
