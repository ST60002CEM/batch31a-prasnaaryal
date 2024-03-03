import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/model/user_profile_model.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/auth_repository.dart';

final profileUseCase = Provider.autoDispose<ProfileUseCase>(
  (ref) => ProfileUseCase(ref.watch(authRepositoryProvider)),
);

class ProfileUseCase {
  final IAuthRepository _authRepository;

  ProfileUseCase(this._authRepository);

  Future<Either<Failure, UserWrapper>> getProfile(
    
  ) =>
      _authRepository.getProfile();
}