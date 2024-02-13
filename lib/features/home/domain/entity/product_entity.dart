import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? sId;
  final String? name;
  final String? category;
  final String? image;
  final String? price;
  final String? description;
  final int? iV;

  const ProductEntity(
      {required this.sId,
      required this.name,
      required this.category,
      required this.image,
      required this.price,
      required this.description,
      required this.iV});

  @override
  List<Object?> get props => [sId, name, category, image, price, description];
}
