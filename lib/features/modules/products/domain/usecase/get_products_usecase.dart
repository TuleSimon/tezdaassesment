import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_product_param.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';
import 'package:tezdaassesment/features/modules/products/domain/repositories/product_repository.dart';

class GetProductsUsecase extends Usecase<List<ProductEntity>, GetProductParam> {
  final ProductRepository _productRepository;

  GetProductsUsecase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Exception, List<ProductEntity>>> call(
      {required GetProductParam params}) {
    return _productRepository.getProducts(params);
  }
}
