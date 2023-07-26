import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phase/constant.dart';
import 'package:phase/features/chart/data/CoinRepo.dart';
import 'package:phase/features/chart/presentation/SearchedCoinTileWidget.dart';

import '../domain/SearchedCoin.dart';
import 'CoinSearchController.dart';
import 'CoinTileWidget.dart';

final searchInputProvider = StateProvider<String>((ref) => '');
final futureSearchProvider = FutureProvider<List<SearchedCoin>>((ref) async {
  final query = ref.watch(searchInputProvider);
  final List<SearchedCoin> aw =
      (await ref.read(coinRepoProvider).searchCoin(query)).cast<SearchedCoin>();
  return aw;
});
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
                      decoration: constantInputDecoration.copyWith(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        ref.read(searchInputProvider.notifier).state = value;
                        ref
                            .read(coinSearchControllerProvider.notifier)
                            .searchCoin();
                      }),
                ),
              ],
            ),
            Expanded(
              child: coins.when(
                data: (data) {
                  return data.isEmpty
                      ? const Text("No search result")
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            debugPrint("inside list");
                            return GestureDetector(
                              onTap: () => context.push("/crypto/chart"),
                              child: SearchedCoinTileWidget(
                                imageUrl: data[index].imageUrl,
                                coinName: data[index].coinName,
                                coinSymbol: data[index].coinSymbol,
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
                      const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Icon(
                          Icons.wifi_tethering_error_rounded_outlined,
                          size: 50,
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
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
