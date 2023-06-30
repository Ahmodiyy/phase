import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/chart/data/CoinRepo.dart';
import 'package:phase/features/chart/domain/Coin.dart';

final coinRepoProvider = Provider<CoinRepo>((ref) {
  return CoinRepo();
});

class CoinController extends AutoDisposeAsyncNotifier<List<Coin>> {
  @override
  FutureOr<List<Coin>> build() async {
    return _getCoins();
  }

  Future<List<Coin>> _getCoins() async {
    return await ref.read(coinRepoProvider).getCoins();
  }
}
