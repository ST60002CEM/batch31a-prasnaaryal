import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/get_profile_usercase.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/logout_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/cart_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_category_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_products_usecase.dart';
import 'package:hamropasalmobile/features/home/presentation/state/home_state.dart';

import '../../domain/use_case/favorite_usecase.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModelProvider, HomeState>(
  (ref) => HomeViewModelProvider(
    getCategoryUseCase: ref.read(getCategoryUseCaseProvider),
    getProductUsecase: ref.read(getProductUseCaseProvider),
    cartUseCase: ref.read(cartUseCaseProvider),
    favoriteUseCase: ref.read(favoriteUseCaseProvider),
    profileUseCaseP: ref.read(profileUseCase),
    logoutUseCase: ref.read(logoutUseCase),
  ),
);

class HomeViewModelProvider extends StateNotifier<HomeState> {
  final GetCategoryUseCase _getCategoryUseCase;
  final GetProductUsecase _getProductUsecase;
  final CartUseCase _cartUseCase;
  final FavoriteUseCase _favoriteUseCase;
  final ProfileUseCase _profileUseCase;
  final LogoutUseCase _logoutUseCase;

  HomeViewModelProvider({
    required GetCategoryUseCase getCategoryUseCase,
    required CartUseCase cartUseCase,
    required FavoriteUseCase favoriteUseCase,
    required GetProductUsecase getProductUsecase,
    required ProfileUseCase profileUseCaseP,
    required LogoutUseCase logoutUseCase,
  })  : _getCategoryUseCase = getCategoryUseCase,
        _getProductUsecase = getProductUsecase,
        _cartUseCase = cartUseCase,
        _favoriteUseCase = favoriteUseCase,
        _profileUseCase = profileUseCaseP,
        _logoutUseCase = logoutUseCase,
        super(HomeState.initial());

  Future<void> getCategory() async {
    var response = await _getCategoryUseCase.getCategory();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(category: r));
  }

  Future<void> getProduct() async {
    var response = await _getProductUsecase.getProducts();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(products: r));
  }

  Future<void> getCartItems() async {
    var response = await _cartUseCase.getFromCart();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(cartItems: r));
  }

  Future<void> removeFromCart(ProductEntity cartEntity) async {
    await _cartUseCase.removeFromCart(cartEntity);
    await getCartItems();
  }

  Future<void> addToCart(ProductEntity cartEntity) async {
    var response = await _cartUseCase.addToCart(cartEntity);
    response.fold(
      (l) => state = state.copyWith(error: l.error),
      (r) async {
        await getCartItems();
      },
    );
  }

  Future<void> getFavoriteItems() async {
    var response = await _favoriteUseCase.getFromFavorite();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(favoriteItems: r));
  }

  Future<void> removeFromFavorite(ProductEntity favoriteEntity) async {
    await _favoriteUseCase.removeFromFavorite(favoriteEntity);
    await getFavoriteItems();
  }

  Future<void> addToFavorite(ProductEntity favoriteEntity) async {
    var response = await _favoriteUseCase.addToFavorite(favoriteEntity);
    response.fold(
      (l) => state = state.copyWith(error: l.error),
      (r) async {
        await getFavoriteItems();
      },
    );
  }

  Future<void> getProfile() async {
    var response = await _profileUseCase.getProfile();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(userWrapper: r));
  }

  Future<void> logOut() async {
    var response = await _logoutUseCase.logout();
    response.fold((l) => state = state.copyWith(error: l.error),
        (r) => state = state.copyWith(loggedOut: true));
  }
}
