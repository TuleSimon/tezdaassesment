import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/navigation/go_router.dart';

final sl = GetIt.instance;

Future<void> initCoreInjections() async {
  sl.registerLazySingleton<GoRouter>(() => appRouter);
}
