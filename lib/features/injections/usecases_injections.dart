import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/login_usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/register_usecase.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_categories_usecase.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_products_usecase.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_single_product_usecase.dart';

Future<void> initUsecasesInjections() async {
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => GetProductsUsecase(productRepository: sl()));
  sl.registerLazySingleton(() => GetCategoriesUsecase(productRepository: sl()));
  sl.registerLazySingleton(
      () => GetSingleProductUsecase(productRepository: sl()));
}
