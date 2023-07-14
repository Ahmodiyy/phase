class Price {
  final int time;
  final double price;

  Price({
    required this.time,
    required this.price,
  });
  factory Price.fromList(List<dynamic> list) {
    return Price(
      time: list[0],
      price: list[1],
    );
  }
}
