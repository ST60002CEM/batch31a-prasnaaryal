import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/domain/use_case/get_products_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetProductUsecase>(),
])
void main() {
  late MockGetProductUsecase mockGetProductUsecase;

  setUpAll(() async {
    mockGetProductUsecase = MockGetProductUsecase();
  });

  group('test add hotels', () {
    setUpAll(() async {
      /// if provided certain values return the proper result
      final productList = [
        ProductEntity(
          sId: '1',
          name: 'Product 1',
          category: 'Category 1',
          description: 'Description 1',
          price: '50',
          image: 'Image 1',
          iV: 1,
        ),
      ];

      when(
        mockGetProductUsecase.getProducts(),
      ).thenAnswer(
        (_) async => Right(productList),
      );
    });


   




  });
}
