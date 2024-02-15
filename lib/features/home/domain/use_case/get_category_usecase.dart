import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/repository/home_repository.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/repository/home_repository.dart';

final getCategoryUseCaseProvider = Provider.autoDispose<GetCategoryUseCase>(
  (ref) => GetCategoryUseCase(homeRepository: ref.read(homeRepositoryProvider)),
);

class GetCategoryUseCase {
  final IHomeRepository _homeRepository;

  const GetCategoryUseCase({required IHomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<Either<Failure, CategoryEntity>> getCategory() =>
      _homeRepository.getCategory();
}
