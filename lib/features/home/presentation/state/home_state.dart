import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<ProductEntity>? products;
  final CategoryEntity? category;
  final bool? showMessage;

  HomeState({
    required this.isLoading,
    this.error,
    this.products,
    this.category,
    this.showMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: null,
      products: null,
      category: null,
      showMessage: false,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? error,
    List<ProductEntity>? products,
    CategoryEntity? category,
    bool? showMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
      category: category ?? this.category,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, error: $error, showMessage: $showMessage)';
}
