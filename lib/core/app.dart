import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';
import 'package:hamropasalmobile/config/themes/app_theme.dart';
import 'package:hamropasalmobile/core/common/provider/theme_provider.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/presentation/view/login_view.dart';
import 'package:hamropasalmobile/features/home/presentation/views/bottom_tab_bar.dart';
import 'package:hamropasalmobile/features/home/presentation/views/home_page.dart';
import 'package:khalti_flutter/localization/khalti_localizations.dart';

import '../features/auth/domain/use_case/auth_status_usecase.dart';

class App extends ConsumerWidget {
  final GlobalKey<NavigatorState> navigationKey;
  const App({super.key, required this.navigationKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatusUseCase = ref.watch(authStatusUsecase);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: AppTheme.getApplicationTheme(themeMode: themeMode),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        KhaltiLocalizations.delegate,
      ],
      onGenerateInitialRoutes: (String initialRoute) {
        return [
          MaterialPageRoute(
            builder: (_) => FutureBuilder<String>(
              future: _getInitialRoute(authStatusUseCase),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _getScreen(snapshot.data!);
                } else {
                  return const Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                }
              },
            ),
          ),
        ];
      },
      routes: AppRoute.getApplicationRoute(),
    );
  }

  Widget _getScreen(String initialRoute) {
    switch (initialRoute) {
      case AppRoute.loginRoute:
        return const LoginView();
      case AppRoute.homeRoute:
        return const PersistentBottomNavigationBar();
      default:
        return const Scaffold();
    }
  }

  Future<String> _getInitialRoute(AuthStatusUseCase authStatusUseCase) async {
    var status = await authStatusUseCase.getUserStatus();
    switch (status) {
      case Status.authenticated:
        return AppRoute.homeRoute;
      case Status.unAuthenticated:
        return AppRoute.loginRoute;
      default:
        return AppRoute.loginRoute;
    }
  }
}
