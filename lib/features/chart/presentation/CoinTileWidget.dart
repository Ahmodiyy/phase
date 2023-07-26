import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phase/features/chart/domain/Price.dart';

class CoinTileWidget extends ConsumerWidget {
  final String imageUrl;
  final String coinName;
  final String coinSymbol;
  final dynamic priceChange24h;
  final dynamic priceChangePercentage;
  final dynamic currentPriceInDollars;
  final List<Price> coinPrice24h;
  const CoinTileWidget({
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
    required this.priceChange24h,
    required this.priceChangePercentage,
    required this.currentPriceInDollars,
    required this.coinPrice24h,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                imageUrl,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        coinName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Text(
                    coinSymbol.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 15),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Container(
                child: CustomPaint(
                  child: Container(),
                  painter:
                      CondensedPriceChart(coinPrice24h, priceChangePercentage),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$$currentPriceInDollars',
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            double.tryParse(priceChange24h.toString())!
                                .toStringAsFixed(2)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            double.tryParse(priceChangePercentage.toString())!
                                .toStringAsFixed(2)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: double.tryParse(
                                        priceChangePercentage.toString())!
                                    .isNegative
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CondensedPriceChart extends CustomPainter {
  List<Price> price;
  double priceChangePercentage;
  CondensedPriceChart(this.price, this.priceChangePercentage);
  @override
  void paint(Canvas canvas, Size size) {
    final double minX = price.first.time.toDouble();
    final double maxX = price.last.time.toDouble();
    final double minY = price
        .map((point) => point.price)
        .reduce((a, b) => a < b ? a : b)
        .toDouble();
    final double maxY = price
        .map((point) => point.price)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();

    final List<Offset> points = price.map((point) {
      final x = (point.time.toDouble() - minX) / (maxX - minX) * size.width;
      final y =
          (1 - (point.price.toDouble() - minY) / (maxY - minY)) * size.height;
      return Offset(x, y);
    }).toList();

    final linePaint = Paint()
      ..color = double.tryParse(priceChangePercentage.toString())!.isNegative
          ? Colors.red
          : Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
