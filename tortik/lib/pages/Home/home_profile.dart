import 'package:flutter/material.dart';
import 'package:tortik/Services/auth.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/main.dart';


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
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: const [
              Padding(padding: EdgeInsets.only(left: 40)),
              Text("Профиль",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 200)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 40)),
              Text(CurrentUserInfo.email),
            ],
          ),



          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 33)),
              _getLogOutButton(context)
            ],
          ),

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
    },child: const Text("Выйти из профиля",
      style: TextStyle(fontSize: 13, fontFamily: 'Roboto', color: Colors.red),
    ),);
  }
}