import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/repository/user_remote_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';


final userRepositoryProvider = Provider.autoDispose<IUserRepository>(
  (ref) => ref.read(userRemoteRepositoryProvider),
);

abstract class IUserRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
}
