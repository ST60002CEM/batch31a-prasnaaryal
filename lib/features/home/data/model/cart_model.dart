import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/home/data/model/product_model.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTableConstant.cartTableId)
class CartModel extends HiveObject {
  @HiveField(0)
  int count;

  @HiveField(1)
  ProductModel productModel;

  CartModel({required this.count, required this.productModel});

  CartEntity toEntity() {
    return CartEntity(
      productModel: productModel.toEntity(),
      count: count,
    );
  }

  static CartModel fromEntity(CartEntity entity) {
    return CartModel(
      productModel: ProductModel.fromEntity(entity.productModel),
      count: entity.count,
    );
  }
}
