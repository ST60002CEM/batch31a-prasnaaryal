import 'package:equatable/equatable.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

class FavoriteEntity extends Equatable {
  final int count;

  final ProductEntity productModel;

  const FavoriteEntity({required this.count, required this.productModel});

  @override
  List<Object?> get props => [count, productModel];
}
