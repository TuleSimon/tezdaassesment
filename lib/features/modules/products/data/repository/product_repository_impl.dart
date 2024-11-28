import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_by_id_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/product_datasource.dart';
import 'package:tezdaassesment/features/modules/products/data/models/product_dto.dart';
import 'package:tezdaassesment/features/modules/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasource productDatasource;

  ProductRepositoryImpl({required this.productDatasource});
  @override
  Future<Either<Exception, List<CategoryDto>>> getCategories(NoParams params) =>
      productDatasource.getCategories(params);

  @override
  Future<Either<Exception, List<ProductDTO>>> getProducts(
          GetProductParam params) =>
      productDatasource.getProducts(params);

  @override
  Future<Either<Exception, ProductDTO>> getSingleProduct(GetByIdParam params) =>
      productDatasource.getSingleProduct(params);
}
