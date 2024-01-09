import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/repository/user_repository.dart';


final addUserUseCaseProvider = Provider.autoDispose<AddUserUseCase>(
  (ref) => AddUserUseCase(
    repository: ref.read(userRepositoryProvider)),
);

class AddUserUseCase {
  final IUserRepository repository;

  AddUserUseCase({required this.repository});

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return await repository.registerUser(user);
  }
}
