import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:phase/features/chart/domain/Coin.dart';
import 'package:phase/features/chart/domain/Price.dart';

class CoinRepo {
  Future<List<Coin>> getCoins() async {
    Response response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false&locale=en"));
    if (response.statusCode == 200) {
      return compute(_parseCoins, response.body);
    } else {
      throw Exception('Failed to load coins\'s data');
    }
  }

  List<Coin> _parseCoins(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Coin>((json) => Coin.fromJson(json)).toList();
  }

  Future<List<Price>> getCoinPrice(String coinId) async {
    Response response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=1"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prices = data["prices"];
      debugPrint(data["prices"].toString());
      return prices.map<Price>((price) => Price.fromList(price)).toList();
    } else {
      throw Exception('Failed to load coins\'s data');
    }
  }
}

List<dynamic> _parseCoinPrice(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Coin>((json) => Coin.fromJson(json)).toList();
}

final coinRepoProvider = Provider<CoinRepo>((ref) {
  return CoinRepo();
});
