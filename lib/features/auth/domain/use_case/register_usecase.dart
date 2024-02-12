import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final registerUseCaseProvider = Provider.autoDispose<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

class RegisterUseCase {
  final IAuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity entity) =>
      _authRepository.registerUser(entity);
}
