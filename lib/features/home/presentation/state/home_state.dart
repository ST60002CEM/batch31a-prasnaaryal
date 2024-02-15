import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<ProductEntity>? products;
  final CategoryEntity? category;
  final bool? showMessage;
  final List<CartEntity>? cartItems;

  HomeState({
    required this.isLoading,
    this.error,
    this.products,
    this.category,
    this.showMessage,
    this.cartItems,
  });

  factory HomeState.initial() {
    return HomeState(
        isLoading: false,
        error: null,
        products: null,
        category: null,
        showMessage: false,
        cartItems: []);
  }

  HomeState copyWith({bool? isLoading,
      String? error,
      List<ProductEntity>? products,
      CategoryEntity? category,
      bool? showMessage,
      List<CartEntity>? cartItems}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        products: products ?? this.products,
        category: category ?? this.category,
        showMessage: showMessage ?? this.showMessage,
        cartItems: cartItems ?? this.cartItems);
  }

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, error: $error, showMessage: $showMessage)';
}
