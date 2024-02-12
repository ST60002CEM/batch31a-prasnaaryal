import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/repository/auth_repository.dart';

import '../repository/auth_repository.dart';

final uploadImageUseCaseProvider = Provider.autoDispose<UploadImageUseCase>(
  (ref) => UploadImageUseCase(ref.read(authRepositoryProvider)),
);

class UploadImageUseCase {
  final IAuthRepository _authRepository;

  UploadImageUseCase(this._authRepository);

  Future<Either<Failure, String>> uploadProfilePicture(File file) =>
      _authRepository.uploadProfilePicture(file);
}
