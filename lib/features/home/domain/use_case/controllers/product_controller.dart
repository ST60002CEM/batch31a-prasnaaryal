import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

class ProductNotifier extends StateNotifier<List<ProductEntity>> {
  ProductNotifier() : super([]);

  // isSelect Change State

  void isSelectItem(int pid, int index) {
    state = [
      for (final product in state)
        if (product.iV == pid) product,
    ];
  }

  void incrementQty(int pid) {
    state = [
      for (final product in state) product,
    ];
  }

  void decreaseQty(int pid) {
    state = [
      for (final product in state) product,
    ];
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<ProductEntity>>((ref) {
  return ProductNotifier();
});
