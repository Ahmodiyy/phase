import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/chart/data/CoinRepo.dart';
import 'package:phase/features/chart/domain/SearchedCoin.dart';
import 'package:phase/features/chart/presentation/SearchCoin.dart';

class CoinSearchController
    extends AutoDisposeAsyncNotifier<List<SearchedCoin>> {
  @override
  FutureOr<List<SearchedCoin>> build() async {
    return await ref.read(coinRepoProvider).searchCoin("bitcoin");
  }

  Future<void> searchCoin() async {
    final query = ref.watch(searchInputProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await ref.read(coinRepoProvider).searchCoin(query);
    });
  }
}
