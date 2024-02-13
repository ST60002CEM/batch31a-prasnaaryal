import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_category_usecase.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_products_usecase.dart';
import 'package:hamropasalmobile/features/home/presentation/state/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModelProvider, HomeState>(
  (ref) => HomeViewModelProvider(
    getCategoryUseCase: ref.read(getCategoryUseCaseProvider),
    getProductUsecase: ref.read(getProductUseCaseProvider),
  ),
);

class HomeViewModelProvider extends StateNotifier<HomeState> {
  final GetCategoryUseCase _getCategoryUseCase;
  final GetProductUsecase _getProductUsecase;

  HomeViewModelProvider(
      {required GetCategoryUseCase getCategoryUseCase,
      required GetProductUsecase getProductUsecase})
      : _getCategoryUseCase = getCategoryUseCase,
        _getProductUsecase = getProductUsecase,
        super(HomeState.initial());

  

  Future<void> getCategory() async {
    var response = await _getCategoryUseCase.getCategory();
    response.fold((l) => state.copyWith(error: l.error),
        (r) => state.copyWith(category: r));
  }

  Future<void> getProduct() async {
    var response = await _getProductUsecase.getProducts();
    response.fold((l) => state.copyWith(error: l.error),
        (r) => state.copyWith(products: r));
  }
}
