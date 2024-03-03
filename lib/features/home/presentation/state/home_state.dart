import 'package:hamropasalmobile/features/auth/data/model/user_profile_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

import '../../domain/entity/favorite_entity.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<ProductEntity>? products;
  final CategoryEntity? category;
  final bool? showMessage;
  final List<CartEntity>? cartItems;
  final UserWrapper? userWrapper;
  final List<FavoriteEntity>? favoriteItems;
  final bool? loggedOut;

  HomeState({
    required this.isLoading,
    this.error,
    this.products,
    this.category,
    this.showMessage,
    this.cartItems,
    this.userWrapper,
    this.favoriteItems,
    this.loggedOut,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: null,
      products: null,
      category: null,
      showMessage: false,
      cartItems: [],
      favoriteItems: [],
      userWrapper: null,
      loggedOut: false,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? error,
    List<ProductEntity>? products,
    CategoryEntity? category,
    bool? showMessage,
    List<CartEntity>? cartItems,
    List<FavoriteEntity>? favoriteItems,
    UserWrapper? userWrapper,
    bool? loggedOut,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
      category: category ?? this.category,
      showMessage: showMessage ?? this.showMessage,
      cartItems: cartItems ?? this.cartItems,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      userWrapper: userWrapper ?? this.userWrapper,
      loggedOut: loggedOut ?? this.loggedOut,
    );
  }

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, error: $error, showMessage: $showMessage)';
}
