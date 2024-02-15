import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/repository/home_repository.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/repository/home_repository.dart';

final cartUseCaseProvider = Provider.autoDispose<CartUseCase>(
  (ref) => CartUseCase(homeRepository: ref.read(homeRepositoryProvider)),
);

class CartUseCase {
  final IHomeRepository _homeRepository;

  const CartUseCase({required IHomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<Either<Failure, List<CartEntity>>> getFromCart() async {
    return await _homeRepository.getFromCart();
  }

  Future<Either<Failure, void>> removeFromCart(ProductEntity cartEntity) async {
    return await _homeRepository.removeFromCart(cartEntity);
  }

  Future<Either<Failure, List<CartEntity>>> addToCart(ProductEntity cartEntity) async {
    return await _homeRepository.addToCart(cartEntity);
  }

}
