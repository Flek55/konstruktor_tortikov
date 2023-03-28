///File works with local data source

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


abstract class LocalDataSource{

  Future<String> getLoginStatus();
  Future<void> setLoginStatus(String userLoginStatus,
      String userLogin, String userPassword);
  Future<String> getUserLogin();
  Future<String> getUserPassword();
}

const CACHED_USER_LOGIN_STATUS = "CACHED_USER_LOGIN_STATUS";
const CACHED_USER_LOGIN = "CACHED_USER_LOGIN";
const CACHED_USER_PASSWORD = "CACHED_USER_PASSWORD";

class LocalDataAnalyse implements LocalDataSource{
  final SharedPreferences sp;

  LocalDataAnalyse({required this.sp});

  @override
  Future<String> getLoginStatus() async {
      final jsonLoginStatus = sp.getString(CACHED_USER_LOGIN_STATUS);
      if (jsonLoginStatus != null) {
        print("SUCCESS DECODE!!!!");
        return Future.value(jsonDecode(jsonLoginStatus));
      }else{
        print("FAIL DECODE");
        return '0';
      }
  }

  @override
  Future<String> getUserLogin() async{
    final jsonUserLogin = sp.getString(CACHED_USER_LOGIN);
    if (jsonUserLogin != null) {
      print("SUCCESS DECODE!!!!");
      return Future.value(jsonDecode(jsonUserLogin));
    }else{
      print("FAIL DECODE");
      return '0';
    }
  }

  @override
  Future<String> getUserPassword() async{
    final jsonUserPassword = sp.getString(CACHED_USER_PASSWORD);
    if (jsonUserPassword != null) {
      print("SUCCESS DECODE!!!!");
      return Future.value(jsonDecode(jsonUserPassword));
    }else{
      print("FAIL DECODE");
      return '0';
    }
  }

  @override
  Future<void> setLoginStatus(String userLoginStatus,
      String userLogin, String userPassword) async {
    final String jsonLoginStatus = jsonEncode(userLoginStatus);
    final String jsonUserLogin = jsonEncode(userLogin);
    final String jsonUserPassword = jsonEncode(userPassword);
    sp.setString(CACHED_USER_LOGIN_STATUS, jsonLoginStatus);
    sp.setString(CACHED_USER_LOGIN, jsonUserLogin);
    sp.setString(CACHED_USER_PASSWORD, jsonUserPassword);
    print("SUCCESS!!");
    return Future.value(jsonLoginStatus);
  }
}