import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource_impl.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_products_usecase.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/state/product_state.dart';

@Riverpod(keepAlive: true)
class ProductsNotifier extends Notifier<ProductState> {
  final GetProductsUsecase getProductsUsecase =
      GetIt.instance<GetProductsUsecase>();

  @override
  ProductState build() {
    state = const ProductState(loading: true);
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
}

final productsProvider =
    NotifierProvider<ProductsNotifier, ProductState>(ProductsNotifier.new);
