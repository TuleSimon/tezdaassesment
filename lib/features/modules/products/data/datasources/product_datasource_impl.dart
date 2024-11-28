import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/core/utils/network/NetworkCall.dart';
import 'package:tezdaassesment/features/core/utils/network/NetworkRoutes.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_by_id_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource.dart';
import 'package:tezdaassesment/features/modules/products/data/models/product_dto.dart';

CancelToken? cancelToken;

class ProductDatasourceImpl extends ProductDatasource {
  final HNetworkcall networkCall;
  final PreferenceManager preferenceManager;

  ProductDatasourceImpl(
      {required this.networkCall, required this.preferenceManager});

  @override
  Future<Either<Exception, List<CategoryDto>>> getCategories(
      NoParams params) async {
    try {
      final Either<Exception, List<CategoryDto>> response = await networkCall
          .getList(Networkroutes.getCategories.route, fromJson: (data) {
        return CategoryDto.fromMap(data);
      }, fromCache: () async {
        final categoriess =
            await preferenceManager.getValue(PreferenceKeys.categories);
        if (categoriess != null) {
          final jsonn = json.decode(categoriess) as List<dynamic>;
          final categories = jsonn
              .map((e) => CategoryDto.fromMap(e as Map<String, dynamic>))
              .toList();
          return Right(categories);
        }
        return Left(NetworkException());
      });
      response.fold(left, (categoris) {
        preferenceManager.setValue(PreferenceKeys.categories,
            json.encode(categoris.map((e) => e.toMap()).toList()));
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, List<ProductDTO>>> getProducts(
      GetProductParam params) async {
    try {
      final Either<Exception, List<ProductDTO>> response = await networkCall
          .getList(Networkroutes.getProducts.route, queryParams: params.toMap(),
              fromJson: (data) {
        return ProductDTO.fromMap(data);
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, ProductDTO>> getSingleProduct(
      GetByIdParam params) async {
    try {
      final Either<Exception, ProductDTO> response = await networkCall.get(
          "${Networkroutes.getProducts.route}/${params.id}", fromJson: (data) {
        return ProductDTO.fromMap(data);
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }
}
