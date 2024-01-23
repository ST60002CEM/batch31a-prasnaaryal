import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/themes.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';
import 'package:hamropasalmobile/config/themes/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: AppTheme.getApplicationTheme(isDark: false),
      initialRoute: AppRoute.registerRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
