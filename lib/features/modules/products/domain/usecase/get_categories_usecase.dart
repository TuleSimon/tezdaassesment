import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';
import 'package:tezdaassesment/features/modules/products/domain/repositories/product_repository.dart';

class GetCategoriesUsecase extends Usecase<List<CategoryEntity>, NoParams> {
  final ProductRepository _productRepository;

  GetCategoriesUsecase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  Future<Either<Exception, List<CategoryEntity>>> call(
      {required NoParams params}) {
    return _productRepository.getCategories(params);
  }
}
