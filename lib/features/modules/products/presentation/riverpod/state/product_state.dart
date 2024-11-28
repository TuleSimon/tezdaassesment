import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final bool loading;
  final String? error;
  final bool network;
  final GetProductParam params;
  final bool poorNetwork;
  final int? activeCategoryId;

  const ProductState({
    this.products = const [],
    this.loading = false,
    this.error,
    this.params = const GetProductParam(),
    this.network = true,
    this.poorNetwork = false,
    this.activeCategoryId = -1,
  });

  // CopyWith method to allow state updates
  ProductState copyWith({
    List<ProductEntity>? products,
    bool? loading,
    String? error,
    bool? network,
    GetProductParam? param,
    bool? poorNetwork,
    int? activeCategoryId,
  }) {
    return ProductState(
      products: products ?? this.products,
      params: param ?? params,
      loading: loading ?? this.loading,
      error: error,
      network: network ?? false,
      poorNetwork: poorNetwork ?? false,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        products,
        params,
        loading,
        error,
        network,
        poorNetwork,
        activeCategoryId
      ];
}
