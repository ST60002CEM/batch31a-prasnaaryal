import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/network/hive_service.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'core/app.dart';

const String testPublicKey = 'test_public_key_dc74e0fd57cb46cd93832aee0a507256';
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
