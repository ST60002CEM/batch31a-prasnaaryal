import 'package:flutter/material.dart';
import 'package:hamropasalmobile/widgets/custom_appbar.dart';
import 'package:hamropasalmobile/widgets/custom_navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'HamroPasal'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
