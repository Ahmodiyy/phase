import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chart extends ConsumerWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container()),
            Expanded(flex: 3, child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
