import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final bool loading;
  final String? error;
  final bool network;
  final GetProductParam params;
  final List<ProductEntity> favourites;
  final bool poorNetwork;
  final int? activeCategoryId;
  final ProductEntity? productDetails;
  final bool? productDetailsLoading;
  final String? productDetailsError;

  const ProductState({
    this.products = const [],
    this.loading = false,
    this.error,
    this.productDetails,
    this.productDetailsLoading,
    this.productDetailsError,
    this.favourites = const [],
    this.params = const GetProductParam(),
    this.network = true,
    this.poorNetwork = false,
    this.activeCategoryId = -1,
  });

  // CopyWith method to allow state updates
  ProductState copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? favourites,
    bool? loading,
    String? error,
    bool? network,
    GetProductParam? param,
    bool? poorNetwork,
    int? activeCategoryId,
    ProductEntity? productDetails,
    bool? productDetailsLoading,
    String? productDetailsError,
  }) {
    return ProductState(
      products: products ?? this.products,
      favourites: favourites ?? this.favourites,
      params: param ?? params,
      loading: loading ?? this.loading,
      error: error,
      productDetailsLoading:
          productDetailsLoading ?? this.productDetailsLoading,
      productDetailsError: productDetailsError ?? this.productDetailsError,
      productDetails: productDetails ?? this.productDetails,
      network: network ?? false,
      poorNetwork: poorNetwork ?? false,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
    );
  }

  // CopyWith method to allow state updates
  ProductState copyWith2({
    List<ProductEntity>? products,
    List<ProductEntity>? favourites,
    bool? loading,
    String? error,
    bool? network,
    GetProductParam? param,
    bool? poorNetwork,
    int? activeCategoryId,
    ProductEntity? productDetails,
    bool? productDetailsLoading,
    String? productDetailsError,
  }) {
    return ProductState(
      products: products ?? this.products,
      favourites: favourites ?? this.favourites,
      params: param ?? params,
      loading: loading ?? this.loading,
      error: error,
      productDetailsLoading:
          productDetailsLoading ?? this.productDetailsLoading,
      productDetailsError: productDetailsError ?? this.productDetailsError,
      productDetails: productDetails,
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
        favourites,
        productDetails,
        productDetailsLoading,
        productDetailsError,
        activeCategoryId
      ];
}
