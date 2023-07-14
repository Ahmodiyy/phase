import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/chart/data/CoinRepo.dart';
import 'package:phase/features/chart/domain/Coin.dart';
import 'package:phase/features/chart/domain/Price.dart';

class CoinController extends AutoDisposeAsyncNotifier<List<Coin>> {
  @override
  FutureOr<List<Coin>> build() async {
    return _getCoinsAndPrices();
  }

  Future<List<Coin>> _getCoinsAndPrices() async {
    List<Coin> coins = await ref.read(coinRepoProvider).getCoins();
    for (Coin coin in coins) {
      List<Price> price = await _getCoinPrice(coin.id);
      coin.coinPrice24h = price;
    }
    return coins;
  }

  Future<List<Price>> _getCoinPrice(String coinId) async {
    return await ref.read(coinRepoProvider).getCoinPrice(coinId);
  }
}
