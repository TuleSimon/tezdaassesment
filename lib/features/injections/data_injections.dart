import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezdaassesment/features/core/utils/network/IntercetorWrapper.dart';
import 'package:tezdaassesment/features/core/utils/network/LoggingInterceptor.dart';
import 'package:tezdaassesment/features/core/utils/network/NetworkCall.dart';
import 'package:tezdaassesment/features/core/utils/network/network_info.dart';
import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager_impl.dart';

Future<void> initDataInjections() async {
  sl.registerLazySingleton<Interceptor>(() => LoggerInterceptor());
  sl.registerLazySingleton<InterceptorsWrapper>(() => HDioIntercetorWrapper,
      instanceName: "wrapper");
  sl.registerLazySingleton<Dio>(
      () => Dio()..interceptors.addAll([sl(), HDioIntercetorWrapper]));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<PreferenceManager>(
      () => PreferenceManagerImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<HNetworkcall>(
      () => NetworkCall(dio: sl(), networkInfo: sl()));
}
