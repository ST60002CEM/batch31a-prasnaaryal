import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final logoutUseCase = Provider.autoDispose<LogoutUseCase>(
  (ref) => LogoutUseCase(authRepository : ref.watch(authRepositoryProvider)),
);


class LogoutUseCase{
  final IAuthRepository _authRepository;

  LogoutUseCase({required IAuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> logout() =>
      _authRepository.logout();

}