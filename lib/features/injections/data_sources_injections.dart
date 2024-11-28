import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/AuthenticationRemote.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/AuthenticationRemoteImpl.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource_impl.dart';

Future<void> initDataSourcesInjections() async {
  sl.registerLazySingleton<IAuthenticationRemote>(() =>
      IAuthenticationRemoteImpl(networkCall: sl(), preferenceManager: sl()));

  sl.registerLazySingleton<ProductDatasource>(
      () => ProductDatasourceImpl(networkCall: sl(), preferenceManager: sl()));
}
