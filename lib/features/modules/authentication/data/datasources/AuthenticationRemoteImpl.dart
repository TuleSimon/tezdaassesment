import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/core/utils/network/NetworkCall.dart';
import 'package:tezdaassesment/features/core/utils/network/NetworkRoutes.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/AuthenticationRemote.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/AuthenticationParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfileParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfilePicParams.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/file_model.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/jwt_model.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/common/utils.dart';

class IAuthenticationRemoteImpl extends IAuthenticationRemote {
  final HNetworkcall networkCall;
  final PreferenceManager preferenceManager;

  IAuthenticationRemoteImpl(
      {required this.networkCall, required this.preferenceManager});

  @override
  Future<Either<Exception, LoggedInUser>> login(LoginParams params) async {
    try {
      final Either<Exception, JwtDto> response = await networkCall
          .post(Networkroutes.loginUrl.route, body: params.toJson(),
              fromJson: (data) {
        final jwt = JwtDto.fromMap(data);
        preferenceManager.storeJwt(jwt);
        return jwt;
      });
      return response.fold((left) async {
        return Left(left);
      }, (jwt) async {
        final profile = await refreshProfile();
        await profile.fold((left) {}, (right) async {
          await preferenceManager.storeUserData(right.copyWith(
              token: jwt.access_token, refreshToken: jwt.refresh_token));
        });
        return profile;
      });
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, LoggedInUser>> refreshProfile() async {
    try {
      final jwt = await preferenceManager.getJwtData();
      final Either<Exception, LoggedInUser> response = await networkCall
          .get(Networkroutes.getProfile.route, fromJson: (data) {
        return LoggedInUser.fromMap(data);
      });
      await response.fold((left) {}, (right) async {
        await preferenceManager.storeUserData(right.copyWith(
            token: jwt?.access_token, refreshToken: jwt?.refresh_token));
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, LoggedInUser>> refreshProfile2(
      Updateprofileparams profile) async {
    try {
      final Either<Exception, LoggedInUser> response = await networkCall
          .get(Networkroutes.getProfile.route, fromJson: (data) {
        return LoggedInUser.fromMap(data);
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, LoggedInUser>> updateProfile(
      Updateprofileparams params) async {
    try {
      String? photo;
      if (params.avatar != null) {
        final result = await updateProfilePic(
            UpdateprofilePicparams(path: params.avatar!));
        final uploadRes = result.fold((left) {
          return Left(left);
        }, (right) {
          photo = right.location;
          return null;
        });
        if (uploadRes != null) {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      }
      final currentUser = await preferenceManager.getUserData2();
      final Either<Exception, LoggedInUser> response = await networkCall.put(
          "${Networkroutes.registerUser.route}/${currentUser?.id}",
          body: params.copyWith(avatar: photo).toMap(), fromJson: (data) {
        return LoggedInUser.fromMap(data);
      });
      await response.fold((left) {}, (right) async {
        await preferenceManager.storeUserData(right.copyWith(
            token: currentUser?.token,
            refreshToken: currentUser?.refreshToken));
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, FileDataDto>> updateProfilePic(
      UpdateprofilePicparams params) async {
    try {
      final compressedFile = await compressImage(params.path);
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(compressedFile,
            contentType: DioMediaType("image", "*"),
            filename: DateTime.now().millisecond.toString()),
      });

      final Either<Exception, FileDataDto> response = await networkCall
          .post(Networkroutes.updatePicture.route, body: formData,
              fromJson: (data) {
        return FileDataDto.fromMap(data);
      });

      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }

  @override
  Future<Either<Exception, LoggedInUser>> registerUser(
      RegisterUserParams params) async {
    try {
      String photo = "https://i.pravatar.cc/300";
      if (params.picture != null) {
        final result = await updateProfilePic(
            UpdateprofilePicparams(path: params.picture!));
        final uploadRes = result.fold((left) {
          return Left(left);
        }, (right) {
          photo = right.fileName;
          return null;
        });
        if (uploadRes != null) {
          return Left(ServerException(message: UNKNOWN_ERROR_STRING));
        }
      }
      final Either<Exception, LoggedInUser> response = await networkCall.post(
          Networkroutes.registerUser.route,
          body: params.copyWith(picture: photo).toJson(), fromJson: (data) {
        return LoggedInUser.fromMap(data);
      });
      response.fold((left) async {
        Left(left);
      }, (user) async {
        preferenceManager.storeUserData(user);
        return user;
      });
      return response;
    } catch (err) {
      return Left(ServerException(message: UNKNOWN_ERROR_STRING));
    }
  }
}
