import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/Services/app_user.dart';
import 'package:tortik/Services/auth.dart';
import 'package:tortik/Services/cache.dart';
import 'package:tortik/Services/db_data.dart';
import 'package:tortik/main.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool showLoading = false;
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(padding: EdgeInsets.only(top: height / 6.5)),
            const Image(image: AssetImage('assets/logo.jpg')),
            const Text(
              'Вкус французской\nклассики',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 25, color: Color(0xFFF4D5BC)),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text(
              'Сеть кондитерских Франсуа Бодреро в самом\n'
              'центре Москвы',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 13, color: Color(0xFF707B7C)),
            ),
            const Padding(padding: EdgeInsets.only(top: 90)),
            _getIconButton(context),
            _getLoading(context),
          ]))
        ]));
  }

  _getIconButton(context) {
    final AuthService _authService = AuthService();
    final ProductsData pd = ProductsData();
    return Visibility(
        visible: !inProgress,
        child: IconButton(
          icon: const Icon(Icons.east),
          iconSize: 65,
          color: const Color(0xFFF4D5BC),
          onPressed: inProgress == false
              ? () async {
                  setState(() {
                    showLoading = true;
                    inProgress = true;
                  });
                  SharedPreferences _sp = await SharedPreferences.getInstance();
                  LocalDataAnalyse _LDA = LocalDataAnalyse(sp: _sp);
                  String status = await _LDA.getLoginStatus();
                  if (status == "1") {
                    String user_login = await _LDA.getUserLogin();
                    CurrentUserData.email = user_login;
                    String user_password = await _LDA.getUserPassword();
                    CurrentUserData.pass = user_password;
                    CurrentUserData.name =
                        await _authService.getUserDisplayName();
                    AppUser? user =
                        await _authService.signInWithEmailAndPassword(
                            user_login.trim(), user_password.trim());
                    if (user != null) {
                      await pd.parseData();
                      await pd.parseLikedProducts(user.id);
                      inProgress = false;
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (r) => false);
                    } else {
                      inProgress = false;
                      Navigator.pushReplacementNamed(context, '/logger');
                    }
                  } else {
                    inProgress = false;
                    Navigator.pushReplacementNamed(context, '/logger');
                  }
                }
              : null,
        ));
  }

  _getLoading(context) {
    return Visibility(
        visible: showLoading,
        child: LoadingAnimationWidget.waveDots(
            color: const Color(0xFFF4D5BC), size: 60));
  }
}
