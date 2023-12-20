import 'package:flutter/material.dart';
import 'package:hamropasalmobile/widgets/custom_appbar.dart';
import 'package:hamropasalmobile/widgets/custom_navbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'HamroPasal'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
