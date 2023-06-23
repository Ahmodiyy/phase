import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:phase/features/chart/presentation/CoinTileWidget.dart';

class Crypto extends ConsumerWidget {
  const Crypto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Market",
                        style: Theme.of(context).textTheme.displayLarge,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        "Crypto",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return CoinTileWidget(
                      imageUrl:
                          'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                      coinName: '',
                      coinSymbol: '',
                      priceChange24h: '',
                      priceChangePercentage: '',
                      currentPriceInDollars: '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
