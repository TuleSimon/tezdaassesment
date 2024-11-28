import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/core/utils/usecases/usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfileParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

class UpdateProfileUsecase extends Usecase<LoggedInUser, Updateprofileparams> {
  final AuthRepository authRepository;

  UpdateProfileUsecase({required this.authRepository});

  @override
  Future<Either<Exception, LoggedInUser>> call(
      {required Updateprofileparams params}) async {
    return authRepository.updateProfile(params);
  }
}
