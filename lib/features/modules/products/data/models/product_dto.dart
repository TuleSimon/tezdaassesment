import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';

class ProductDTO extends ProductEntity {
  ProductDTO({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.images,
  });

  // Convert from Map (JSON) to ProductDTO
  factory ProductDTO.fromMap(Map<String, dynamic> map) {
    return ProductDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      description: map['description'] as String,
      category: CategoryDto(
        id: map['category']['id'] as int,
        name: map['category']['name'] as String,
        image: map['category']['image'] as String,
      ),
      images: List<String>.from(map['images']),
    );
  }

  static List<String> _extractImages(String imagesString) {
    // Regular expression to match URLs inside quotes
    final regex = RegExp(r'"(https?://[^"]+)"');
    return regex
        .allMatches(imagesString) // Find all matches
        .map((match) => match.group(1)!) // Extract the matched group
        .toList();
  }

  // Convert ProductDTO to Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': {
        'id': category.id,
        'name': category.name,
        'image': category.image,
      },
      'images': images,
    };
  }
}

class CategoryDto extends CategoryEntity {
  const CategoryDto({
    required super.id,
    required super.name,
    required super.image,
  });

  @override
  List<Object> get props => [id, name, image];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
    };
  }

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    return CategoryDto(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
