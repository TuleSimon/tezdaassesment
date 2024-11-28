import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_by_id_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/data/models/product_dto.dart';

abstract class ProductRepository {
  ///
  /// calls the products endpoint to get products
  ///
  /// throws a [ServerException] for all error codes
  /// and a [NetworkException] for network errors
  /// returns a [List<ProductDTO>]
  Future<Either<Exception, List<ProductDTO>>> getProducts(
      GetProductParam params);

  ///
  /// calls the get categories endpont to get categories
  ///
  /// throws a [ServerException] for all error codes
  /// and a [NetworkException] for network errors
  /// returns a [List<CategoryDto>]
  Future<Either<Exception, List<CategoryDto>>> getCategories(NoParams params);

  ///
  /// calls the products endpoint to get a single products
  ///
  /// throws a [ServerException] for all error codes
  /// and a [NetworkException] for network errors
  /// returns a [ProductDTO]
  Future<Either<Exception, ProductDTO>> getSingleProduct(GetByIdParam params);
}
