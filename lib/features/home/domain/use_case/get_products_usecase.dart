import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/repository/home_repository.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/repository/home_repository.dart';

final getProductUseCaseProvider = Provider.autoDispose<GetProductUsecase>(
  (ref) => GetProductUsecase(homeRepository: ref.read(homeRepositoryProvider)),
);

class GetProductUsecase {
  final IHomeRepository _homeRepository;

  const GetProductUsecase({required IHomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<Either<Failure, List<ProductEntity>>> getProducts() =>
      _homeRepository.getProducts();
  
}
