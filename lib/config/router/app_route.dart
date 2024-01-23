

import 'package:hamropasalmobile/features/auth/presentation/view/login_view.dart';
import 'package:hamropasalmobile/features/auth/presentation/view/register_view.dart';


class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String batchStudentRoute = '/batchStudent';
  static const String googleMapRoute = '/googleMap';
    static const String internetCHecker = '/internetChecker';

  static getApplicationRoute() {
    return {
      // splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      // homeRoute: (context) => const HomeView(),
      registerRoute: (context) => const RegisterView(),
      // internetCHecker:(context)=> const InternetChecker()
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}