import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';

class CategoryState extends Equatable {
  final List<CategoryEntity> categories;
  final bool loading;
  final String? error;
  final bool network;
  final bool poorNetwork;
  final int? activeCategoryId;

  const CategoryState({
    this.categories = const [],
    this.loading = false,
    this.error,
    this.network = true,
    this.poorNetwork = false,
    this.activeCategoryId = -1,
  });

  // CopyWith method to allow state updates
  CategoryState copyWith({
    List<CategoryEntity>? categories,
    bool? loading,
    String? error,
    bool? network,
    bool? poorNetwork,
    int? activeCategoryId,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      error: error,
      network: network ?? false,
      poorNetwork: poorNetwork ?? false,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
    );
  }

  @override
  List<Object?> get props =>
      [categories, loading, error, network, poorNetwork, activeCategoryId];
}
