import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phase/features/onboarding/presentation/OnboardingScreen.dart';
import 'package:phase/features/chart/presentation/Crypto.dart';
import 'package:phase/features/chart/presentation/Chart.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
        path: '/crypto',
        builder: (context, state) => const Crypto(),
        routes: [
          GoRoute(
            path: 'chart',
            builder: (context, state) => const Chart(),
          ),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
