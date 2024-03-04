import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hamropasalmobile/features/auth/presentation/view/login_view.dart';
import 'package:hamropasalmobile/features/home/presentation/views/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              height: 300,
              width: 400,
            ),
            const SizedBox(
              height: 30,
            ),
            if (defaultTargetPlatform == TargetPlatform.iOS)
              const CupertinoActivityIndicator(
                color: Color.fromARGB(255, 255, 182, 26),
                radius: 20,
              )
            else
              const CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 194, 51),
              )
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 75, 45),
        title: const Text('Intro Page'),
      ),
    );
  }
}
