import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/cart_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_category_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_products_usecase.dart';
import 'package:hamropasalmobile/features/home/presentation/state/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModelProvider, HomeState>(
  (ref) => HomeViewModelProvider(
    getCategoryUseCase: ref.read(getCategoryUseCaseProvider),
    getProductUsecase: ref.read(getProductUseCaseProvider),
    cartUseCase: ref.read(cartUseCaseProvider),
  ),
);

class HomeViewModelProvider extends StateNotifier<HomeState> {
  final GetCategoryUseCase _getCategoryUseCase;
  final GetProductUsecase _getProductUsecase;
  final CartUseCase _cartUseCase;

  HomeViewModelProvider(
      {required GetCategoryUseCase getCategoryUseCase,
      required CartUseCase cartUseCase,
      required GetProductUsecase getProductUsecase})
      : _getCategoryUseCase = getCategoryUseCase,
        _getProductUsecase = getProductUsecase,
        _cartUseCase = cartUseCase,
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
}
