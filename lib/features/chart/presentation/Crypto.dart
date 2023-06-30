import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:phase/features/chart/domain/Coin.dart';
import 'package:phase/features/chart/presentation/CoinController.dart';
import 'package:phase/features/chart/presentation/CoinTileWidget.dart';

final coinControllerProvider =
    AsyncNotifierProvider.autoDispose<CoinController, List<Coin>>(() {
  return CoinController();
});

class Crypto extends ConsumerWidget {
  const Crypto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins = ref.watch(coinControllerProvider);
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
                  child: coins.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      debugPrint("inside list");
                      return CoinTileWidget(
                        imageUrl: data[index].imageUrl,
                        coinName: data[index].coinName,
                        coinSymbol: data[index].coinSymbol,
                        priceChange24h: data[index].priceChange24h,
                        priceChangePercentage:
                            data[index].priceChangePercentage,
                        currentPriceInDollars:
                            data[index].currentPriceInDollars,
                      );
                    },
                  );
                },
                error: (object, stack) =>
                    Center(child: Text(object.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
