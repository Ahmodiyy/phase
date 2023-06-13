import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Crypto extends ConsumerWidget {
  const Crypto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(flex: 1, child: Container()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ),
    );
  }
}
