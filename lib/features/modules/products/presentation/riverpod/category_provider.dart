import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_categories_usecase.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/state/category_state.dart';

@Riverpod(keepAlive: false)
class CategoryNotifier extends Notifier<CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase =
      GetIt.instance<GetCategoriesUsecase>();

  @override
  CategoryState build() {
    state = const CategoryState(loading: true);
    getCategories();
    return const CategoryState(loading: true);
  }

  Future<void> getCategories() async {
    state = state.copyWith(loading: true);
    final result = await getCategoriesUsecase(params: const NoParams());
    result.fold((error) {
      if (error is NetworkException) {
        state = state.copyWith(network: true, loading: false);
      }
      if (error is TimeoutException) {
        state = state.copyWith(poorNetwork: true, loading: false);
      }
      if (error is ServerException) {
        state = state.copyWith(error: error.message, loading: false);
      }
    }, (res) {
      state = state.copyWith(categories: res, loading: false);
    });
  }

  void selectCategory(int? id) {
    state = state.copyWith(activeCategoryId: id ?? -1);
  }
}

final categoryProvider =
    NotifierProvider<CategoryNotifier, CategoryState>(CategoryNotifier.new);
