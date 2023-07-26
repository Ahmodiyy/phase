class SearchedCoin {
  final String id;
  final String imageUrl;
  final String coinName;
  final String coinSymbol;

  SearchedCoin({
    required this.id,
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
  });
  factory SearchedCoin.fromJson(Map<String, dynamic> json) {
    return SearchedCoin(
      id: json['id'],
      imageUrl: json["large"],
      coinName: json["name"],
      coinSymbol: json["symbol"],
    );
  }
}
