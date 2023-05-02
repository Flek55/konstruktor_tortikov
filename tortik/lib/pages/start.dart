import 'package:flutter/material.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/Services/auth.dart';
import 'package:tortik/Services/app_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tortik/main.dart';


class Start extends StatefulWidget{
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  @override
  Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: const Color(0xFF000000),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 120)),
                        const Image(image: AssetImage('assets/logo.jpg')),
                        const Text('Вкус французской\nклассики',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 25,
                              color: Color(0xFFF4D5BC)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('Сеть кондитерских Франсуа Бодреро в самом\n'
                            'центре Москвы',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 13,
                              color: Color(0xFF707B7C)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 90)),
                        _getIconButton(context),]
                  ))
                ])
        );
  }

  _getIconButton(context){
    final AuthService _authService = AuthService();
    return IconButton(
      icon: const Icon(Icons.east),
      iconSize: 65,
      color: const Color(0xFFF4D5BC),
      onPressed: () async{
        SharedPreferences _sp = await SharedPreferences.getInstance();
        LocalDataAnalyse _LDA = LocalDataAnalyse(sp: _sp);
        String status = await _LDA.getLoginStatus();
        if (status == "1"){
          String user_login = await _LDA.getUserLogin();
          CurrentUserInfo.email = user_login;
          String user_password = await _LDA.getUserPassword();
          AppUser? user = await _authService.signInWithEmailAndPassword(
              user_login.trim(), user_password.trim());
          if (user != null) {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Сохраненные данные неверны!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepOrange,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacementNamed(context, '/logger');
          }
        }else{
          Navigator.pushReplacementNamed(context, '/logger');
        }
      },
    );
  }
}