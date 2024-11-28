import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

class LoginUsecase extends Usecase<LoggedInUser, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Exception, LoggedInUser>> call(
      {required LoginParams params}) async {
    return authRepository.login(params);
  }
}
