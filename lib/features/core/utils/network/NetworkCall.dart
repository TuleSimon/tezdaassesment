import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tezdaassesment/features/core/utils/error/JsonSerilizable.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/core/utils/network/network_info.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource_impl.dart';

const UNKNOWN_ERROR_STRING = "1";
const NOT_LOGGED_IN_ERROR_STRING = "401";
const NETWORK_ERROR = "2";
const POOR_NETWORK = "3";

abstract class HNetworkcall {
  Future<Either<Exception, T>> get<T>(String route,
      {Map<String, String>? queryParams,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, List<T>>> getList<T>(
    String route, {
    Map<String, String>? queryParams,
    T Function(dynamic)? fromJson,
    Future<Either<Exception, List<T>>> Function()? fromCache,
  });

  Future<Either<Exception, T>> post<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, T>> put<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson});

  Future<Either<Exception, List<T>>> postList<T extends JsonSerializable<T>, Y>(
      String route,
      {Map<String, String>? queryParams,
      Y? body,
      T Function(Map<String, dynamic>)? fromJson});

  Future<Either<Exception, T>> patch<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson});
}

class NetworkCall extends HNetworkcall {
  final Dio dio;
  final NetworkInfo networkInfo;

  NetworkCall({required this.dio, required this.networkInfo});

  @override
  Future<Either<Exception, T>> get<T>(String route,
      {Map<String, dynamic>? queryParams,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dio.get(route, queryParameters: queryParams);

        final T result = fromJson(response.data as Map<String, dynamic>);
        return Right(result);
      } on DioException catch (e) {
        if (e.response != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message: message != null
                  ? "${message["message"]} ${message["validationErrors"]?.map((dynamic e) => "${e["field"]}: ${e["errors"].join(", ")}") ?? ""}"
                  : UNKNOWN_ERROR_STRING));
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, List<T>>> getList<T>(String route,
      {Map<String, dynamic>? queryParams,
      T Function(dynamic)? fromJson,
      Future<Either<Exception, List<T>>> Function()? fromCache}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dio.get(route,
            queryParameters: queryParams, cancelToken: cancelToken);

        // Check if the response is a list of maps
        final data = response.data;
        if (data is List) {
          final List<T> result = data
              .map((item) =>
                  (fromJson == null) ? item as T : fromJson(item as dynamic))
              .toList();
          return Right(result);
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          return Left(CancelException());
        }
        if (e.type == DioExceptionType.connectionTimeout) {
          return Left(TimeoutException());
        }
        if (e.response != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message: message != null
                  ? "${message["message"]} ${message["validationErrors"]?.map((dynamic e) => "${e["field"]}: ${e["errors"].join(", ")}") ?? ""}"
                  : UNKNOWN_ERROR_STRING));
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      if (fromCache != null) {
        return await fromCache();
      }
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> post<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dio.post(route, queryParameters: queryParams, data: body);
        final T result = fromJson(response.data as Map<String, dynamic>);
        return Right(result);
      } on DioException catch (e) {
        debugPrint("Here1 ${e.response?.data}");
        debugPrint("Here2 ${e.message}");
        if (e.response?.data != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message: message != null
                  ? "${message["message"]} ${message["validationErrors"]?.map((dynamic e) => "${e["field"]}: ${e["errors"].join(", ")}") ?? ""}"
                  : UNKNOWN_ERROR_STRING));
        } else {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            // Handle timeout error
            return Left(TimeoutException());
          } else if (e.type == DioExceptionType.connectionError) {
            // Handle socket errors like network connection issues
            return Left(NetworkException());
          }
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        debugPrint("Here ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        debugPrint("Here 2 ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> put<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dio.put(route, queryParameters: queryParams, data: body);
        final T result = fromJson(response.data as Map<String, dynamic>);
        return Right(result);
      } on DioException catch (e) {
        debugPrint("Here1 ${e.response?.data}");
        debugPrint("Here2 ${e.message}");
        if (e.response?.data != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message: message != null
                  ? "${message["message"]} ${message["validationErrors"]?.map((dynamic e) => "${e["field"]}: ${e["errors"].join(", ")}") ?? ""}"
                  : UNKNOWN_ERROR_STRING));
        } else {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            // Handle timeout error
            return Left(TimeoutException());
          } else if (e.type == DioExceptionType.connectionError) {
            // Handle socket errors like network connection issues
            return Left(NetworkException());
          }
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        debugPrint("Here ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        debugPrint("Here 2 ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, List<T>>> postList<T extends JsonSerializable<T>, Y>(
      String route,
      {Map<String, String>? queryParams,
      Y? body,
      T Function(Map<String, dynamic>)? fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dio.post(route, queryParameters: queryParams, data: body);
        final data = response.data;
        if (data is List) {
          final List<T> result = data
              .map((item) => (item! is Map<String, dynamic> || fromJson == null)
                  ? item as T
                  : fromJson(item as Map<String, dynamic>))
              .toList();
          return Right(result);
        } else {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on DioException catch (e) {
        debugPrint("Here1 ${e.response?.data}");
        debugPrint("Here2 ${e.message}");
        if (e.response?.data != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message:
                  message != null ? message["message"] : UNKNOWN_ERROR_STRING));
        } else {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            // Handle timeout error
            return Left(TimeoutException());
          } else if (e.type == DioExceptionType.connectionError) {
            // Handle socket errors like network connection issues
            return Left(NetworkException());
          }
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        debugPrint("Here ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        debugPrint("Here 2 ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }

  @override
  Future<Either<Exception, T>> patch<T, Y>(String route,
      {Map<String, String>? queryParams,
      Y? body,
      required T Function(Map<String, dynamic>) fromJson}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dio.patch(route, queryParameters: queryParams, data: body);
        final T result = fromJson(response.data as Map<String, dynamic>);
        return Right(result);
      } on DioException catch (e) {
        debugPrint("Here1 ${e.response?.data}");
        debugPrint("Here2 ${e.message}");
        if (e.response?.data != null) {
          final message = e.response?.data as Map<String, dynamic>?;
          return Left(ServerException(
              message:
                  message != null ? message["message"] : UNKNOWN_ERROR_STRING));
        } else {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            // Handle timeout error
            return Left(TimeoutException());
          } else if (e.type == DioExceptionType.connectionError) {
            // Handle socket errors like network connection issues
            return Left(NetworkException());
          }
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      } on Exception catch (e) {
        debugPrint("Here ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      } catch (e) {
        debugPrint("Here 2 ${e}");
        return Left(ServerException(message: UNKNOWN_ERROR_STRING));
      }
    } else {
      return Left(NetworkException());
    }
  }
}
