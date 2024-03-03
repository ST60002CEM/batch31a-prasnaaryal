import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/repository/home_repository.dart';
import 'package:hamropasalmobile/features/home/domain/entity/favorite_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/repository/home_repository.dart';

final favoriteUseCaseProvider = Provider.autoDispose<FavoriteUseCase>(
  (ref) => FavoriteUseCase(homeRepository: ref.read(homeRepositoryProvider)),
);

class FavoriteUseCase {
  final IHomeRepository _homeRepository;

  const FavoriteUseCase({required IHomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<Either<Failure, List<FavoriteEntity>>> getFromFavorite() async {
    return await _homeRepository.getFromFavorite();
  }

  Future<Either<Failure, void>> removeFromFavorite(
      ProductEntity favoriteEntity) async {
    return await _homeRepository.removeFromFavorite(favoriteEntity);
  }

  Future<Either<Failure, List<FavoriteEntity>>> addToFavorite(
      ProductEntity favoriteEntity) async {
    return await _homeRepository.addToFavorite(favoriteEntity);
  }
}
