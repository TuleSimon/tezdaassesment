import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/theme/hegmof_theme.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/injections/core_injections.dart';
import 'package:tezdaassesment/features/injections/data_injections.dart';
import 'package:tezdaassesment/features/injections/data_sources_injections.dart';
import 'package:tezdaassesment/features/injections/repositories_injections.dart';

import 'features/injections/usecases_injections.dart';
import 'features/injections/utils_injection.dart';

Future<void> initInjections() async {
  await Future.wait([
    initCoreInjections(),
    initDataInjections(),
    initDataSourcesInjections(),
    initRepositoriesInjections(),
    initUtilsInjections(),
    initUsecasesInjections(),
  ]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _registerContext(BuildContext context) {
    // Register context if it hasn't been registered yet
    if (!getIt.isRegistered<BuildContext>()) {
      getIt.registerSingleton<BuildContext>(context);
      getIt.registerSingleton<AppLocalizations>(context.getLocalization()!);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GetIt.instance<GoRouter>();

    return ProviderScope(
      child: ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: MaterialApp.router(
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.title,
                localizationsDelegates: const [
                  AppLocalizations.delegate, //,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                debugShowCheckedModeBanner: false,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('el'),
                ],
                theme: AppThemeLight,
                darkTheme: AppThemeDark,
                themeMode: ThemeMode.system,
                routerConfig: _router,
                builder: (context, child) {
                  _registerContext(context);
                  return child!;
                },
              ),
            );
          }),
    );
  }
}
