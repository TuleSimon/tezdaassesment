import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';

class RefreshProfileUsecase extends Usecase<LoggedInUser, NoParams> {
  final AuthRepository authRepository;

  RefreshProfileUsecase({required this.authRepository});

  @override
  Future<Either<Exception, LoggedInUser>> call(
      {required NoParams params}) async {
    return authRepository.refreshProfile();
  }
}
