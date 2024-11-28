import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:tezdaassesment/features/core/navigation/go_router.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';

final HDioIntercetorWrapper = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final preference = GetIt.instance<PreferenceManager>();
      final user = await preference.getJwtData();
      final token = user?.access_token;
      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return handler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler handler) {
// Do something with response data.
// If you want to reject the request with a error message,
// you can reject a `DioException` object using `handler.reject(dioError)`.
    return handler.next(response);
  },
  onError: (DioException error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 401) {
      final path = appRouter.state?.path;
      final isInAUthScreen = [AppRoutes.LoginScreen]
              .map((route) => route.route)
              .firstWhereOrNull((route) {
            debugPrint('route');
            return route == path;
          }) !=
          null;
      if (!isInAUthScreen) {
        final preference = GetIt.instance<PreferenceManager>();
        preference.clearUserData();
        error.requestOptions.headers.clear();
      }
    }
    return handler.next(error);
  },
);
