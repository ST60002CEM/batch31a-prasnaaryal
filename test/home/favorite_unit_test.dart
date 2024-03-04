import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/model/favorite_model.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/favorite_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/favorite_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FavoriteUseCase>(),
])
void main() {
  late MockFavoriteUseCase mockFavoriteUseCase;

  setUpAll(() async {
    mockFavoriteUseCase = MockFavoriteUseCase();
  });

  group('test add to favorites', () {
    setUpAll(() async {
      // Arrange
      final productEntity = ProductEntity(
        sId: '1234567890',
        name: 'Test Hotel',
        price: '100',
        category: 'test',
        image: 'Test Image',
        description: 'testt',
        iV: 1,
      );

      final favoriteModel = FavoriteModel(
        count: 1,
        productModel: ProductModel.fromEntity(productEntity),
      );

      // Act
      when(
        mockFavoriteUseCase.addToFavorite(
          productEntity, // Pass the productEntity directly
        ),
      ).thenAnswer((_) async => Right(true as List<FavoriteEntity>));
    });
  });

  test('should return a Failure with error message', () async {
    // Arrange
    final mockErrorModel = Failure(
      error: 'Please enter hotel details',
    );

    // Act
    when(
      mockFavoriteUseCase.addToFavorite(
        null, // Pass the appropriate argument (null or any default value)
      ),
    ).thenAnswer((_) async => Left(mockErrorModel));

    // Call the addToFavorite method
    final result = await mockFavoriteUseCase.addToFavorite(null);

    // Verify the expected result
    expect(result, Left(mockErrorModel));
  });

  test('should remove from favorite', () async {
    // Arrange
    final productModel = ProductModel(
      sId: '1234567890',
      name: 'Test Hotel',
      price: '100',
      category: 'test',
      image: 'Test Image',
      description: 'testt',
      iV: 1,
    );

    final productEntity = productModel.toEntity(); // Convert to ProductEntity

    // Act
    when(
      mockFavoriteUseCase.removeFromFavorite(
        productEntity, // Pass ProductEntity instead of ProductModel
      ),
    ).thenAnswer((_) async => Right(true as List<FavoriteEntity>));
  });

  // Your test logic goes here
}
