import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/favorite_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';
// dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
@HiveType(typeId: HiveTableConstant.favoriteTableId)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int count;

  @HiveField(1)
  ProductModel productModel;

  FavoriteModel({required this.count, required this.productModel});

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      productModel: productModel.toEntity(),
      count: count,
    );
  }

  static FavoriteModel fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      productModel: ProductModel.fromEntity(entity.productModel),
      count: entity.count,
    );
  }
}
