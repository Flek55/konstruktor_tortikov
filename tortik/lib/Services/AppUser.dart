import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  String? id;

  AppUser(User? user){
    id = user?.uid;
  }
}