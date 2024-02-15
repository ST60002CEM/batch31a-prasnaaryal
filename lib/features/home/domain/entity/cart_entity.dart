import 'package:equatable/equatable.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';

class CartEntity extends Equatable {
  final int count;

  final ProductEntity productModel;

  const CartEntity({required this.count, required this.productModel});

  @override
  List<Object?> get props => [count, productModel];
}
