import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchedCoinTileWidget extends ConsumerWidget {
  final String imageUrl;
  final String coinName;
  final String coinSymbol;

  const SearchedCoinTileWidget({
    required this.imageUrl,
    required this.coinName,
    required this.coinSymbol,
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
              flex: 9,
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
          ],
        ),
      ),
    );
  }
}
