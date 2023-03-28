import 'package:flutter/material.dart';
import 'package:tortik/Services/auth.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 200)),
          _getLogOutButton(context)
        ],
      ),
    );
  }

  _getLogOutButton(context){
    return TextButton(style: TextButton.styleFrom(
      disabledForegroundColor: Colors.deepPurple.withOpacity(0.38),
    ),onPressed: () async{
      _authService.signOut();
      SharedPreferences sp = await SharedPreferences.getInstance();
      LocalDataAnalyse _LDA = LocalDataAnalyse(sp: sp);
      _LDA.setLoginStatus("0","","");
      Navigator.pushNamedAndRemoveUntil(context, "/logger", (r) => false);
    },child: const Text("Выйти",
      style: TextStyle(fontSize: 25, fontFamily: 'Roboto', color: Colors.black),
    ),);
  }
}