import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_by_id_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource_impl.dart';
import 'package:tezdaassesment/features/modules/products/data/models/product_dto.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_products_usecase.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_single_product_usecase.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/state/product_state.dart';

@Riverpod(keepAlive: true)
class ProductsNotifier extends Notifier<ProductState> {
  final GetProductsUsecase getProductsUsecase =
      GetIt.instance<GetProductsUsecase>();
  final PreferenceManager preferenceManager =
      GetIt.instance<PreferenceManager>();
  final GetSingleProductUsecase getSingleProductUsecase =
      GetIt.instance<GetSingleProductUsecase>();

  @override
  ProductState build() {
    state = const ProductState(loading: true);
    getFavourites();
    getProducts();
    return const ProductState(loading: true);
  }

  Future<void> getProducts() async {
    if (state.params.hasMore) {
      cancelToken?.cancel();
      cancelToken = CancelToken();
      state = state.copyWith(loading: true);
      final result = await getProductsUsecase(params: state.params);
      result.fold((error) {
        if (error is NetworkException) {
          state = state.copyWith(network: true, loading: false);
        }
        if (error is TimeoutException) {
          state = state.copyWith(poorNetwork: true, loading: false);
        }
        if (error is CancelException) {
          state = state.copyWith(loading: false);
        }
        if (error is ServerException) {
          state = state.copyWith(error: error.message, loading: false);
        }
      }, (res) {
        final previousProducts = state.products;
        final newProducts = [...previousProducts, ...res];
        state = state.copyWith(
            products: newProducts,
            param: state.params.copyWith(
                hasMore: res.length >= 10,
                categoryId: state.params.categoryId,
                offset: newProducts.length),
            loading: false);
      });
    }
  }

  void getFavourites() async {
    final favouritesJson =
        await preferenceManager.getValueStringList(PreferenceKeys.favourites);
    if (favouritesJson.isNotEmpty) {
      final favourites = favouritesJson
          .map((data) => ProductDTO.fromMap(json.decode(data)))
          .toList();
      state = state.copyWith(favourites: favourites);
    }
  }

  void addFavourites(ProductEntity entity) async {
    final favourites = [...state.favourites, entity];
    await _updateFavs(favourites);
  }

  Future<void> _updateFavs(List<ProductEntity> favourites) async {
    final favouritesJson =
        favourites.map((re) => json.encode(re.toJson())).toList();
    await preferenceManager.setValueList(
        PreferenceKeys.favourites, favouritesJson);
    state = state.copyWith(favourites: favourites);
  }

  void removeFavourites(ProductEntity entity) async {
    final updatedFavourites =
        state.favourites.where((product) => product.id != entity.id).toList();

    await _updateFavs(updatedFavourites);
  }

  void selectCategory(int? id) {
    if (state.params.categoryId != id.toString()) {
      state = state.copyWith(
          products: [],
          loading: true,
          param: state.params
              .copyWith(categoryId: id?.toString(), offset: 0, hasMore: true));
      getProducts();
    }
  }

  void searchProducts(String query) {
    state = state.copyWith(
        products: [],
        loading: true,
        param: state.params.copyWith(
            categoryId: state.params.categoryId?.toString(),
            offset: 0,
            hasMore: true,
            title: query.isEmpty ? null : query));
    getProducts();
  }

  Future<void> getProductDetails(String id) async {
    if (state.productDetailsLoading != true ||
        state.productDetails?.id.toString() != id) {
      state =
          state.copyWith2(productDetailsLoading: true, productDetails: null);
      final res = await getSingleProductUsecase(params: GetByIdParam(id: id));
      res.fold((err) {
        if (err is TimeoutException) {
          state =
              state.copyWith(poorNetwork: true, productDetailsLoading: false);
        }
        if (err is NetworkException) {
          state = state.copyWith(network: true, productDetailsLoading: false);
        }
        if (err is ServerException) {
          state = state.copyWith(
              productDetailsError: err.message, productDetailsLoading: false);
        }
      }, (result) {
        state = state.copyWith(
            productDetails: result, productDetailsLoading: false);
      });
    }
  }
}

final productsProvider =
    NotifierProvider<ProductsNotifier, ProductState>(ProductsNotifier.new);
