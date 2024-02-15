import 'package:dartz/dartz.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

abstract class IHomeRepository {
  Future<Either<Failure, CategoryEntity>> getCategory();
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<CartEntity>>> getFromCart();
  Future<Either<Failure, void>> removeFromCart(ProductEntity cartModel);
  Future<Either<Failure, List<CartEntity>>> addToCart(ProductEntity cartEntity);
}
