import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/AuthenticationRemote.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfileParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfilePicParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/file_model.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final IAuthenticationRemote authenticationRemote;

  AuthRepositoryImpl({required this.authenticationRemote});

  @override
  Future<Either<Exception, LoggedInUser>> login(LoginParams params) =>
      authenticationRemote.login(params);

  @override
  Future<Either<Exception, LoggedInUser>> refreshProfile() =>
      authenticationRemote.refreshProfile();

  @override
  Future<Either<Exception, LoggedInUser>> refreshProfile2(
          Updateprofileparams params) =>
      authenticationRemote.refreshProfile2(params);

  @override
  Future<Either<Exception, LoggedInUser>> updateProfile(
          Updateprofileparams params) =>
      authenticationRemote.updateProfile(params);

  @override
  Future<Either<Exception, LoggedInUser>> registerUser(
          RegisterUserParams params) =>
      authenticationRemote.registerUser(params);

  @override
  Future<Either<Exception, FileDataDto>> updateProfilePic(
          UpdateprofilePicparams params) =>
      authenticationRemote.updateProfilePic(params);
}
