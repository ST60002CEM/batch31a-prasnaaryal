import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/data_source/home_local_data_source.dart';
import 'package:hamropasalmobile/features/home/data/data_source/home_remote_data_source.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/favorite_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/repository/home_repository.dart';

final homeRepositoryProvider = Provider<IHomeRepository>(
  (ref) => HomeRepository(
    homeLocalDataSource: ref.read(homeLocalDataSourceProvider),
    homeRemoteDataSource: ref.read(homeRemoteDataSourceProvider),
  ),
);

class HomeRepository implements IHomeRepository {
  final HomeLocalDataSource _homeLocalDataSource;
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepository(
      {required HomeLocalDataSource homeLocalDataSource,
      required HomeRemoteDataSource homeRemoteDataSource})
      : _homeLocalDataSource = homeLocalDataSource,
        _homeRemoteDataSource = homeRemoteDataSource;

  @override
  Future<Either<Failure, CategoryEntity>> getCategory() async {
    try {
      var category = await _homeLocalDataSource.getCategories();
      if (category != null) {
        return Right(category.toEntity());
      }
      var newCategories = await _homeRemoteDataSource.getCategories();
      await _homeLocalDataSource.saveCategories(newCategories);
      return Right(newCategories.toEntity());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var products = await _homeLocalDataSource.getProducts();
      if (products.isNotEmpty) {
        return Right(products.map((e) => e.toEntity()).toList());
      }
      var newProducts = await _homeRemoteDataSource.getProducts();
      await _homeLocalDataSource.saveProducts(newProducts);
      return Right(newProducts.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getFromCart() async {
    try {
      var cartItems = await _homeLocalDataSource.getAllCart();
      if (cartItems.isNotEmpty) {
        return Right(cartItems.map((e) => e.toEntity()).toList());
      }
      return const Right([]);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFromFavorite() async {
    try {
      var favoriteItems = await _homeLocalDataSource.getAllFavorite();
      if (favoriteItems.isNotEmpty) {
        return Right(favoriteItems.map((e) => e.toEntity()).toList());
      }
      return const Right([]);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(ProductEntity entity) async {
    try {
      await _homeLocalDataSource
          .removeFromCart(ProductModel.fromEntity(entity));
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorite(ProductEntity entity) async {
    try {
      await _homeLocalDataSource
          .removeFromFavorite(ProductModel.fromEntity(entity));
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> addToCart(
      ProductEntity entity) async {
    try {
      await _homeLocalDataSource.addToCart(ProductModel.fromEntity(entity));
      var cartItems = await _homeLocalDataSource.getAllCart();
      return Right(cartItems.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> addToFavorite(
      ProductEntity entity) async {
    try {
      await _homeLocalDataSource.addToFavorite(ProductModel.fromEntity(entity));
      var favoriteItems = await _homeLocalDataSource.getAllFavorite();
      return Right(favoriteItems.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
