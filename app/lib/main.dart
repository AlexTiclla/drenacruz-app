import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DrenaCruz AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B5CAD)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}