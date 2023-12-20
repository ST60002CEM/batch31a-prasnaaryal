import 'package:flutter/material.dart';
import 'package:hamropasalmobile/widgets/custom_appbar.dart';
import 'package:hamropasalmobile/widgets/custom_navbar.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Catalog'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
