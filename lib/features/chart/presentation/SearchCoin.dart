import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/SearchedCoin.dart';
import 'CoinSearchController.dart';
import 'CoinTileWidget.dart';

final coinSearchControllerProvider =
    AsyncNotifierProvider.autoDispose<CoinSearchController, List<SearchedCoin>>(
        () {
  return CoinSearchController();
});

class SearchCoin extends ConsumerWidget {
  const SearchCoin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins = ref.watch(coinSearchControllerProvider);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_sharp)),
              Expanded(
                child: TextFormField(
                  onChanged: (query) {},
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.cancel_outlined)),
            ],
          ),
          Expanded(
              child: coins.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  debugPrint("inside list");
                  return GestureDetector(
                    onTap: () => context.push("/crypto/chart"),
                    child: CoinTileWidget(
                      imageUrl: data[index].imageUrl,
                      coinName: data[index].coinName,
                      coinSymbol: data[index].coinSymbol,
                      priceChange24h: "",
                      priceChangePercentage: "",
                      currentPriceInDollars: "",
                      coinPrice24h: [],
                    ),
                  );
                },
              );
            },
            error: (object, stack) => Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "images/network.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                AutoSizeText(object.toString().toLowerCase()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.invalidate(coinSearchControllerProvider);
                    },
                    child: const Text("Refresh"),
                  ),
                )
              ],
            )),
            loading: () => const Center(child: CircularProgressIndicator()),
          )),
        ],
      ),
    ));
  }
}
