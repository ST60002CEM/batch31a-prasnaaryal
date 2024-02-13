import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/api_endpoints.dart';
import 'package:hamropasalmobile/core/network/http_service.dart';
import 'package:hamropasalmobile/features/home/data/model/category_model.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>(
  (ref) => HomeRemoteDataSource(
    httpService: ref.read(httpServiceProvider),
  ),
);

class HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSource({required httpService}) : _dio = httpService;

  Future<List<ProductModel>> getProducts() async {
    var response = await _dio.get(ApiEndpoints.getAllProducts);
    final listOfProducts = response.data;
    List<ProductModel> products = [];
    listOfProducts.forEach((item) => products.add(ProductModel.fromJson(item)));
    return products;
  }

  Future<CategoryModel> getCategories() async {
    var response = await _dio.get(ApiEndpoints.getCategories);
    return CategoryModel.fromJson(response.data);
  }
}
