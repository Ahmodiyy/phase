import 'Price.dart';

class Coin {
  final String id;
  final String imageUrl;
  final String coinName;
  final String coinSymbol;
  List<Price> coinPrice24h;
  final dynamic priceChange24h;
  final dynamic priceChangePercentage;
  final dynamic currentPriceInDollars;
  Coin({
    required this.id,
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
    required this.coinPrice24h,
    required this.priceChange24h,
    required this.priceChangePercentage,
    required this.currentPriceInDollars,
  });
  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'] as String,
      imageUrl: json["image"] as String,
      coinName: json["name"] as String,
      coinSymbol: json["symbol"] as String,
      priceChange24h: json["price_change_24h"],
      priceChangePercentage: json["price_change_percentage_24h"],
      currentPriceInDollars: json["current_price"],
      coinPrice24h: [],
    );
  }
}
