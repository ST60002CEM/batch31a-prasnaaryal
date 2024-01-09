import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/core/networking/hive_service.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';


final userLocalDataSourceProvider = Provider.autoDispose<UserLocalDataSource>(
  (ref) => UserLocalDataSource(hiveService: ref.read(hiveServiceProvider)),
);

class UserLocalDataSource {
  final HiveService hiveService;

  UserLocalDataSource({
    required this.hiveService
    });

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return const Right(true);
  }

 
}
