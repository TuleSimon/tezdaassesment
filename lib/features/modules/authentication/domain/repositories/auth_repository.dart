import 'package:dartz/dartz.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfileParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfilePicParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/file_model.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/jwt_model.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

abstract class AuthRepository {
  ///
  /// calls the login method to login a user
  ///
  /// throws a [ServerException] for all error codes
  /// and a [NetworkException] for network errors
  /// returns a [LoggedInUserDto]
  Future<Either<Exception, LoggedInUser>> login(LoginParams params);

  ///
  ///
  ///calls the get user profile endpoint to refresh user profile
  Future<Either<Exception, LoggedInUser>> refreshProfile(JwtDto jwt);

  ///
  ///
  ///calls the get user profile endpoint to refresh user profile
  Future<Either<Exception, LoggedInUser>> updateProfile(
      Updateprofileparams params);

  ///
  ///
  ///calls the get user profile endpoint to refresh user profile
  Future<Either<Exception, FileDataDto>> updateProfilePic(
      UpdateprofilePicparams params);

  Future<Either<Exception, LoggedInUser>> registerUser(
      RegisterUserParams params);
}
