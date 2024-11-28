import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/products/data/datasources/params/get_by_id_param.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';
import 'package:tezdaassesment/features/modules/products/domain/repositories/product_repository.dart';

class GetSingleProductUsecase extends Usecase<ProductEntity, GetByIdParam> {
  final ProductRepository _productRepository;

  GetSingleProductUsecase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Exception, ProductEntity>> call(
      {required GetByIdParam params}) {
    return _productRepository.getSingleProduct(params);
  }
}
