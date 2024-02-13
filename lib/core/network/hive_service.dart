import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/home/data/model/category_model.dart';
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
}
