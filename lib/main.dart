import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/network/hive_service.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'core/app.dart';

const String testPublicKey = 'test_secret_key_f9245313f6914fa28328c95aac956871';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await HiveService().init();

  runApp(
    KhaltiScope(
        publicKey: testPublicKey,
        enabledDebugging: true,
        builder: (context, navKey) {
          return ProviderScope(
            child: App(
              navigationKey: navKey,
            ),
          );
        }),
  );
}
