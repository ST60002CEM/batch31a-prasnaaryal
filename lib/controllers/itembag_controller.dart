import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/model/product_model.dart';

List<ProductModel> itembag = [];

class ItemBagNotifier extends StateNotifier<List<ProductModel>> {
  ItemBagNotifier() : super(itembag);

  // Add new item

  void addNewItemBag(ProductModel productModel) {
    state = [...state, productModel];
  }

  // Remove item

  void removeItem(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }
}

final itemBagProvider =
    StateNotifierProvider<ItemBagNotifier, List<ProductModel>>((ref) {
  return ItemBagNotifier();
});
