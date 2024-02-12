import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:hamropasalmobile/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) => AuthRepository(
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
    authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepository(
      {required AuthRemoteDataSource authRemoteDataSource,
      required AuthLocalDataSource authLocalDataSource})
      : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      var response = await _authRemoteDataSource.login(email, password);
      await _authLocalDataSource.saveToken(response);
      return Right(response);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      final response = await _authRemoteDataSource.registerUser(user);
      if (response) {
        return Right(response);
      } else {
        return Left(Failure(error: "User registration Failed"));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final response = await _authRemoteDataSource.uploadPicture(file);
      return Right(response);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Status> userStatus() async {
    try {
      await _authLocalDataSource.getToken();
      return Status.authenticated;
    } catch (e) {
      return Status.unAuthenticated;
    }
  }
}
