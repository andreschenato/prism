import 'package:flutter/material.dart';
import 'package:prism/core/routes/app_router.dart';
import 'package:prism/core/theme/app_theme.dart';

class PrismApp extends StatelessWidget {
  const PrismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Prism',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
