import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/utils/login_validator.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/utils/signup_validator.dart';

Future<void> initUtilsInjections() async {
  sl.registerLazySingleton(() => Loginvalidator(app_localizations: sl()));
  sl.registerLazySingleton(() => Signupvalidator(app_localizations: sl()));
}
