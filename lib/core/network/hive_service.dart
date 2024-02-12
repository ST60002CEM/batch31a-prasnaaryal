import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/auth/data/model/auth_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create object using a provider
final hiveServiceProvider = Provider<HiveService>(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // ======================== Auth Queries ========================

  Future<void> registerUser(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  // Login
  Future<bool> loginUser(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var auths = box.values.toList();
    var auth = auths.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => AuthHiveModel.empty(),
    );

    if (auth == AuthHiveModel.empty()) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var auths = box.values.toList();
    return auths;
  }

  Future<void> deleteUser(String userId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(userId);
  }

  // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }
}
