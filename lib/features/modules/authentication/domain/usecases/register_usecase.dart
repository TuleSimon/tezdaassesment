import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

class RegisterUsecase extends Usecase<LoggedInUser, RegisterUserParams> {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Exception, LoggedInUser>> call(
      {required RegisterUserParams params}) async {
    return authRepository.registerUser(params);
  }
}
