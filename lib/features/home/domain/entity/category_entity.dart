import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? count;
  final List<String>? categories;

  const CategoryEntity({
    this.count,
    this.categories,
  });

  @override
  List<Object?> get props => [count, categories];
}
