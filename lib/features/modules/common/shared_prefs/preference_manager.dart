import 'dart:async';

import 'package:tezdaassesment/features/modules/authentication/data/models/jwt_model.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

abstract class PreferenceManager {
  Stream<LoggedInUser?> getLoggedInUserStream();

  Future<void> storeUserData(LoggedInUser user);
  Future<void> storeJwt(JwtDto user);
  Future<JwtDto?> getJwtData();
  Future<LoggedInUser?> getUserData();
  Future<LoggedInUser?> getUserData2();
  Future<String?> getValue(String key);
  Future<bool> getValueBoolean(String key);
  Future<void> setValueList(String key, List<String> values);
  Future<List<String>> getValueStringList(String key);
  Future<void> setValue(String value, String key);
  Future<void> setValueBoolean(String value, String key);

  void clearUserData();
}

class PreferenceKeys {
  static const String loggedInUser = 'logged_in_user';
  static const String jwt = 'jwt';
  static const String favourites = 'favourites';
  static const String categories = 'categories';
  static const String products = 'products';
  static const String lastKycErrorMessage = 'kyc_error_message';
  static const String lastShownDoKycDate = 'kyc_date';
  static const String hasShownKycCompleted = 'kyc_completed';
}
