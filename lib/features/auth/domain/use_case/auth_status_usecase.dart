import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final authStatusUsecase = Provider.autoDispose<AuthStatusUseCase>(
  (ref) => AuthStatusUseCase(authRepository: ref.watch(authRepositoryProvider)),
);

class AuthStatusUseCase {
  final IAuthRepository _authRepository;

  AuthStatusUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Status> getUserStatus() => _authRepository.userStatus();
}
