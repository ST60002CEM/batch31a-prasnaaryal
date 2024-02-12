import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(authRepositoryProvider)),
);

class LoginUseCase {
  final IAuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) =>
      _authRepository.loginUser(email, password);
}
