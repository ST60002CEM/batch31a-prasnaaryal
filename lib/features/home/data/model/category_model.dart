import 'package:hamropasalmobile/features/home/domain/entity/category_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  int? count;

  @HiveField(1)
  List<String>? categories;

  CategoryModel({this.count, this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(
      categories: categories,
      count: count,
    );
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      categories: entity.categories,
      count: entity.count,
    );
  }
}