class Coin {
  final String imageUrl;
  final String coinName;
  final String coinSymbol;
  final dynamic priceChange24h;
  final dynamic priceChangePercentage;
  final dynamic currentPriceInDollars;
  const Coin({
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
    required this.priceChange24h,
    required this.priceChangePercentage,
    required this.currentPriceInDollars,
  });
  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        imageUrl: json["image"],
        coinName: json["name"],
        coinSymbol: json["symbol"],
        priceChange24h: json["price_change_24h"],
        priceChangePercentage: json["price_change_percentage_24h"],
        currentPriceInDollars: json["current_price"]);
  }
}
