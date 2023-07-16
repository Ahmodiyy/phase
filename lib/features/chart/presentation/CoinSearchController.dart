import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/chart/data/CoinRepo.dart';
import 'package:phase/features/chart/domain/SearchedCoin.dart';

class CoinSearchController
    extends AutoDisposeAsyncNotifier<List<SearchedCoin>> {
  @override
  FutureOr<List<SearchedCoin>> build() async {
    return [];
  }

  Future<void> searchCoin(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await ref.read(coinRepoProvider).searchCoin(query);
    });
  }
}
