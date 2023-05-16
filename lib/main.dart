import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phase/features/onboarding/presentation/OnboardingScreen.dart';
import 'package:phase/features/chart/presentation/Crypto.dart';
import 'package:phase/features/chart/presentation/Chart.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  initialLocation: '/',
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
      theme: ThemeData(
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.all(15),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 35.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black45),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
