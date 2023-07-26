import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
        backgroundColor: const Color(0xffF1F1F2),
        body: coins.when(
          data: (data) {
            final currencyFormatter =
                NumberFormat.currency(locale: 'en_US', symbol: '\$');
            final amount =
                currencyFormatter.format(data.first.currentPriceInDollars);
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(data.first.imageUrl),
                              width: 70,
                              height: 70,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.first.coinName,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  maxLines: 1,
                                ),
                                Text(
                                  data.first.coinSymbol,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 15),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 20,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            amount,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
                            maxLines: 1,
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                data.first.priceChangePercentage.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displaySmall,
                                maxLines: 1,
                              ),
                              Text(
                                data.first.priceChange24h.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 15),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "The price master pattern",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Expanded(
                          child: Image.asset(
                        "images/trend.png",
                        height: 100,
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
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
                      IconButton(
                          onPressed: () => context.go('/crypto/searchCoin'),
                          icon: const Icon(Icons.search))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        debugPrint("inside list");
                        return GestureDetector(
                          onTap: () => context.push("/crypto/chart"),
                          child: CoinTileWidget(
                            imageUrl: data[index].imageUrl,
                            coinName: data[index].coinName,
                            coinSymbol: data[index].coinSymbol,
                            priceChange24h: data[index].priceChange24h,
                            priceChangePercentage:
                                data[index].priceChangePercentage,
                            currentPriceInDollars:
                                data[index].currentPriceInDollars,
                            coinPrice24h: data[index].coinPrice24h,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          error: (object, stack) => Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Icon(
                        Icons.wifi_tethering_error_rounded_outlined,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: AutoSizeText(
                          "Connection error",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: AutoSizeText(
                        object.toString().toLowerCase(),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          ref.invalidate(coinControllerProvider);
                        },
                        child: const Text("Refresh"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
