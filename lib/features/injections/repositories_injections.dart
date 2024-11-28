import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/modules/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/products/data/repository/product_repository_impl.dart';
import 'package:tezdaassesment/features/modules/products/domain/repositories/product_repository.dart';

Future<void> initRepositoriesInjections() async {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authenticationRemote: sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productDatasource: sl()));
}
