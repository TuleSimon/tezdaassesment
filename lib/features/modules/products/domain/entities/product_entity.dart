import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final CategoryEntity category;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  @override
  List<Object> get props => [
        id,
        title,
        price,
        description,
        category,
        images,
      ];
}

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, image];
}
