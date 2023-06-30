import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:phase/features/chart/domain/Coin.dart';

class CoinRepo {
  Future<List<Coin>> getCoins() async {
    Response response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&locale=en"));

    if (response.statusCode == 200) {
      List coinsData = jsonDecode(response.body);
      debugPrint(coinsData[0].toString());
      return coinsData.map((coinData) => Coin.fromJson(coinData)).toList();
    } else {
      throw Exception('Failed to load coins\'s data');
    }
  }
}
