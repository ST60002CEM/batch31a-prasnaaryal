import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTableConstant.productTableId)
class ProductModel extends HiveObject {
  @HiveField(0)
  String? sId;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? category;

  @HiveField(3)
  String? image;

  @HiveField(4)
  String? price;

  @HiveField(5)
  String? description;

  @HiveField(6)
  int? iV;

  ProductModel({
    this.sId,
    this.name,
    this.category,
    this.image,
    this.price,
    this.description,
    this.iV,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      sId: sId,
      name: name,
      category: category,
      image: image,
      price: price,
      description: description,
      iV: iV,
    );
  }

  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
      sId: entity.sId,
      name: entity.name,
      category: entity.category,
      image: entity.image,
      price: entity.price,
      description: entity.description,
      iV: entity.iV,
    );
  }
}
