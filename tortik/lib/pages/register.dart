import 'package:flutter/material.dart';
import 'package:tortik/Services/app_user.dart';
import 'package:tortik/Services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/main.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      CustomPaint(
        painter: BackgroundSignUp(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  _getHeader(),
                  _getInputs(_emailController, _passwordController),
                  _getSignUp(context),
                  _getBottomRow(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return false;

    AppUser? user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());
    CurrentUserData.email = _email.trim();
    if (user == null ) {
      return false;
    } else if (CurrentUserData.email == ""){
      return false;
    }else{
      return true;
    }
  }


  _getHeader() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: const Text(
          'Регистрация аккаунта',
          style: TextStyle(color: Colors.white, fontSize: 37),
        ),
      ),
    );
  }

  _getInputs(emailController, passwordController) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white)),
            style: (const TextStyle(color:Colors.white)),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Пароль',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: (const TextStyle(color:Colors.white)),
            obscureText: true,
            obscuringCharacter: '*',
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  _getSignUp(context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Регистрация',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Container(
              color: Colors.grey,
              child: IconButton(onPressed: () async {
                bool ans = await _registerButtonAction();
                SharedPreferences sp = await SharedPreferences.getInstance();
                LocalDataAnalyse _LDA = LocalDataAnalyse(sp: sp);
                if (ans){
                  _LDA.setLoginStatus("1", _emailController.text.trim(),
                      _passwordController.text.trim());
                  CurrentUserData.email = _emailController.text.trim();
                  CurrentUserData.pass = _passwordController.text.trim();
                  Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
                  _emailController.clear();
                  _passwordController.clear();
                }else{
                  String e = "Неверный логин или пароль!";
                  if(_passwordController.text.length < 6){
                    e = "Пароль должень быть больше 5 символов";
                  }
                  Fluttertoast.showToast(
                      msg: e,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepOrange,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  _passwordController.clear();
                }
              },
                  iconSize: 40,
                  icon: const Icon(Icons.arrow_forward_ios))
          ),
        ],
      ),
    );
  }

  _getBottomRow(context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text("Вход",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundSignUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.black;
    canvas.drawPath(mainBackground, paint);

    // purple
    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.65);
    blueWave.cubicTo(sw * 0.8, sh * 0.8, sw * 0.5, sh * 0.8, sw * 0.45, sh);
    blueWave.lineTo(0, sh);
    blueWave.close();
    paint.color = Colors.black;
    canvas.drawPath(blueWave, paint);

    // Grey
    Path greyPath = Path();
    greyPath.lineTo(sw, 0);
    greyPath.lineTo(sw, sh * 0.3);
    greyPath.cubicTo(sw * 0.65, sh * 0.45, sw * 0.25, sh * 0.35, 0, sh * 0.5);
    greyPath.close();
    paint.color = const Color(0xFF5B2C6F);
    canvas.drawPath(greyPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}