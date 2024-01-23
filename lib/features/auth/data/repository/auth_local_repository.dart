import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final authLocalRepositoryProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthLocalRepository(ref.read(authLocalDataSourceProvider)),
);

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return const Right("");
  }
}