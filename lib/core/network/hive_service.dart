import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/home/data/model/cart_model.dart';
import 'package:hamropasalmobile/features/home/data/model/category_model.dart';
import 'package:hamropasalmobile/features/home/data/model/favorite_model.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Create object using a provider
final hiveServiceProvider = Provider<HiveService>(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(FavoriteModelAdapter());
  }

  // // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteFromDisk();
  }

  Future<void> saveCategories(CategoryModel categoryModel) async {
    var box = await Hive.openBox<CategoryModel>(HiveTableConstant.categoryBox);
    box.add(categoryModel);
  }

  Future<CategoryModel?> getCategories() async {
    var box = await Hive.openBox<CategoryModel>(HiveTableConstant.categoryBox);
    if (box.values.isEmpty) {
      return null;
    }
    return box.values.first;
  }

  Future<void> saveProducts(List<ProductModel> products) async {
    var box = await Hive.openBox<ProductModel>(HiveTableConstant.productBox);
    box.addAll(products);
  }

  Future<List<ProductModel>> getProducts() async {
    var box = await Hive.openBox<ProductModel>(HiveTableConstant.productBox);
    if (box.values.isEmpty) {
      return [];
    }
    return box.values.toList();
  }

  Future<void> removeFromCart(ProductModel productModel) async {
    var box = await Hive.openBox<CartModel>(HiveTableConstant.cartBox);

    // Use indexWhere with custom equality check
    int indexToRemove = box.values.toList().indexWhere(
          (item) =>
              item.productModel.name == productModel.name &&
              item.productModel.price == productModel.price &&
              item.productModel.category == productModel.category,
          // Add other fields for equality check if needed
        );

    if (indexToRemove != -1) {
      CartModel removedItem = box.getAt(indexToRemove)!;

      // Adjusted the logic to correctly handle removing items
      if (removedItem.count <= 1) {
        // If the count is 1 or less, remove the item from the cart
        await box.deleteAt(indexToRemove);
      } else {
        // Otherwise, decrement the count
        removedItem.count -= 1;
        await box.putAt(indexToRemove, removedItem);
      }
    }
  }

  Future<void> removeFromFavorite(ProductModel productModel) async {
    var box = await Hive.openBox<FavoriteModel>(HiveTableConstant.favoriteBox);

    // Use indexWhere with custom equality check
    int indexToRemove = box.values.toList().indexWhere(
          (item) =>
              item.productModel.name == productModel.name &&
              item.productModel.price == productModel.price &&
              item.productModel.category == productModel.category,
          // Add other fields for equality check if needed
        );

    if (indexToRemove != -1) {
      FavoriteModel removedItem = box.getAt(indexToRemove)!;

      // Adjusted the logic to correctly handle removing items
      if (removedItem.count <= 1) {
        // If the count is 1 or less, remove the item from the cart
        await box.deleteAt(indexToRemove);
      } else {
        // Otherwise, decrement the count
        removedItem.count -= 1;
        await box.putAt(indexToRemove, removedItem);
      }
    }
  }

  Future<CartModel> addToCart(ProductModel productModel) async {
    var box = await Hive.openBox<CartModel>(HiveTableConstant.cartBox);

    int existingIndex = box.values.toList().indexWhere(
          (item) =>
              item.productModel.name == productModel.name &&
              item.productModel.price == productModel.price &&
              item.productModel.category == productModel.category,
        );

    if (existingIndex != -1) {
      CartModel existingItem = box.getAt(existingIndex)!;
      existingItem.count += 1;
      await box.putAt(existingIndex, existingItem);
      return existingItem;
    } else {
      var cartModel = CartModel(count: 1, productModel: productModel);
      await box.add(cartModel);
      return cartModel;
    }
  }

  Future<FavoriteModel> addToFavorite(ProductModel productModel) async {
    var box = await Hive.openBox<FavoriteModel>(HiveTableConstant.favoriteBox);

    int existingIndex = box.values.toList().indexWhere(
          (item) =>
              item.productModel.name == productModel.name &&
              item.productModel.price == productModel.price &&
              item.productModel.category == productModel.category,
        );

    if (existingIndex != -1) {
      FavoriteModel existingItem = box.getAt(existingIndex)!;
      existingItem.count += 1;
      await box.putAt(existingIndex, existingItem);
      return existingItem;
    } else {
      var favoriteModel = FavoriteModel(count: 1, productModel: productModel);
      await box.add(favoriteModel);
      return favoriteModel;
    }
  }

  Future<List<CartModel>> getAllCart() async {
    var box = await Hive.openBox<CartModel>(HiveTableConstant.cartBox);
    List<CartModel> cartItems = box.values.toList();
    return cartItems;
  }

  Future<List<FavoriteModel>> getAllFavorite() async {
    var box = await Hive.openBox<FavoriteModel>(HiveTableConstant.favoriteBox);
    List<FavoriteModel> favoriteItems = box.values.toList();
    return favoriteItems;
  }
}
