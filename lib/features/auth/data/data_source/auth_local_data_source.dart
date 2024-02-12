import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(),
);

class AuthLocalDataSource {
  Future<SharedPreferences> _getSharedPreferences() =>
      SharedPreferences.getInstance();

  Future<void> saveToken(String jwtToken) async {
    final sharedPref = await _getSharedPreferences();
    await sharedPref.setString("access_token", jwtToken);
  }

  Future<String> getToken() async {
    final sharedPref = await _getSharedPreferences();
    var jwtToken = sharedPref.getString("access_token");
    if (jwtToken != null) {
      return jwtToken;
    }
    throw Exception("User is not authenticated");
  }
}
