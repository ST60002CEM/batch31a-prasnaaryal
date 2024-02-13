import 'package:dartz/dartz.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/home/data/model/category_model.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

abstract class IHomeRepository {
  Future<Either<Failure, CategoryEntity>> getCategory();
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
