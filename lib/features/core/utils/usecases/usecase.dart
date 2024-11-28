import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Exception, Type>> call({required Params params});
}
