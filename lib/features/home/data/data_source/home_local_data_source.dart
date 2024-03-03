import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/network/hive_service.dart';
import 'package:hamropasalmobile/features/home/data/model/cart_model.dart';
import 'package:hamropasalmobile/features/home/data/model/category_model.dart';
import 'package:hamropasalmobile/features/home/data/model/favorite_model.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';

final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>(
  (ref) => HomeLocalDataSource(hiveService: ref.read(hiveServiceProvider)),
);

class HomeLocalDataSource {
  final HiveService _hiveService;

  HomeLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  Future<void> saveCategories(CategoryModel categoryModel) =>
      _hiveService.saveCategories(categoryModel);

  Future<CategoryModel?> getCategories() => _hiveService.getCategories();

  Future<void> saveProducts(List<ProductModel> productModel) =>
      _hiveService.saveProducts(productModel);

  Future<List<ProductModel>> getProducts() => _hiveService.getProducts();

  Future<CartModel> addToCart(ProductModel cartModel) =>
      _hiveService.addToCart(cartModel);

  Future<FavoriteModel> addToFavorite(ProductModel favoriteModel) =>
      _hiveService.addToFavorite(favoriteModel);

  Future<void> removeFromCart(ProductModel cartModel) =>
      _hiveService.removeFromCart(cartModel);

  Future<void> removeFromFavorite(ProductModel favoriteModel) =>
      _hiveService.removeFromFavorite(favoriteModel);

  Future<List<CartModel>> getAllCart() => _hiveService.getAllCart();
  Future<List<FavoriteModel>> getAllFavorite() => _hiveService.getAllFavorite();
}
