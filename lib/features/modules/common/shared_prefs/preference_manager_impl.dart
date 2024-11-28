import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezdaassesment/features/modules/authentication/data/models/jwt_model.dart';
import 'package:tezdaassesment/features/modules/common/encryption_helper.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';

class PreferenceManagerImpl implements PreferenceManager {
  final SharedPreferences sharedPreferences;

  PreferenceManagerImpl({required this.sharedPreferences});

  final StreamController<LoggedInUser?> loggedInUserStream =
      StreamController<LoggedInUser?>();
  late Stream<LoggedInUser?> broascastStream =
      loggedInUserStream.stream.asBroadcastStream();

  @override
  Future<void> storeUserData(LoggedInUser user) async {
    // debugPrint("Storing User Data ${user.toString()}");
    await sharedPreferences.setString(PreferenceKeys.loggedInUser,
        EncryptionHelper().encryptData(json.encode(user.toMap())));
    refreshUserStream();
  }

  @override
  Future<void> storeJwt(JwtDto jwt) async {
    // debugPrint("Storing User Data ${user.toString()}");
    await sharedPreferences.setString(PreferenceKeys.jwt,
        EncryptionHelper().encryptData(json.encode(jwt.toMap())));
    refreshUserStream();
  }

  void refreshUserStream() async {
    final userData = await getUserData();
    loggedInUserStream.add(userData);
  }

  @override
  Future<LoggedInUser?> getUserData() async {
    try {
      final jsonString =
          sharedPreferences.getString(PreferenceKeys.loggedInUser);
      debugPrint(jsonString);
      if (jsonString != null) {
        final user = LoggedInUser.fromMap(
            json.decode(EncryptionHelper().decryptData(jsonString)));
        try {
          loggedInUserStream.add(user);
        } catch (e) {
          debugPrint(e.toString());
        }
        return user;
      }
    } catch (e) {}
    return null;
  }

  @override
  Future<JwtDto?> getJwtData() async {
    try {
      final jsonString = sharedPreferences.getString(PreferenceKeys.jwt);
      debugPrint(jsonString);
      if (jsonString != null) {
        final decrypted = EncryptionHelper().decryptData(jsonString);
        debugPrint(decrypted);
        final user = JwtDto.fromMap(json.decode(decrypted));
        return user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<LoggedInUser?> getUserData2() async {
    final jsonString = sharedPreferences.getString(PreferenceKeys.loggedInUser);
    debugPrint(jsonString);
    if (jsonString != null) {
      final user = LoggedInUser.fromMap(
          json.decode(EncryptionHelper().decryptData(jsonString)));
      loggedInUserStream.add(user);
      return user;
    }

    return null;
  }

  @override
  void clearUserData() async {
    await sharedPreferences.remove(PreferenceKeys.loggedInUser);
    refreshUserStream();
  }

  @override
  Stream<LoggedInUser?> getLoggedInUserStream() {
    return broascastStream;
  }

  @override
  Future<String?> getValue(String key) async {
    return sharedPreferences.getString(EncryptionHelper().decryptData(key));
  }

  @override
  Future<bool> getValueBoolean(String key) async {
    return sharedPreferences.getBool(key) ?? false;
  }

  @override
  Future<void> setValue(String value, String key) async {
    sharedPreferences.setString(key, EncryptionHelper().encryptData(value));
  }

  @override
  Future<void> setValueBoolean(String value, String key) async {
    sharedPreferences.setString(key, value);
  }
}
