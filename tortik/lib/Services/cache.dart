import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource{

  Future<bool> getLoginStatus();
  Future<void> setLoginStatus();
}

class LocalDataAnalyse implements LocalDataSource{
  final SharedPreferences sp;

  LocalDataAnalyse({required this.sp});

  @override
  Future<bool> getLoginStatus() async {
    throw UnimplementedError();
  }

  @override
  Future<void> setLoginStatus() async {
    final String jsonLoginStatus;
  }
}