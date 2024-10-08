import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tortik/Services/app_user.dart';
import 'package:tortik/Services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/Services/db_data.dart';
import 'package:tortik/main.dart';
import 'package:tortik/pages/Home/home_interaction.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isButtonPressed = false;
  bool inProgress = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundSignIn(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  _getHeader(),
                  _getInputs(_emailController, _passwordController),
                  _getLogIn(context),
                  _getBottomRow(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List> _loginButtonAction() async {
    inProgress = true;
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return [false,"0"];

    AppUser? user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      return [false,"0"];
    } else {
      return [true,user.id];
    }
  }

  _getHeader() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: const Text(
          'Добро пожаловать',
          style: TextStyle(color: Colors.white, fontSize: 37),
        ),
      ),
    );
  }

  _getInputs(emailController, passwordController) {
    return Expanded(
        flex: 4,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          TextField(
            cursorColor: Colors.white,
            controller: emailController,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                ),
                labelText: 'E-Mail',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                )),
            style: (const TextStyle(color: Colors.white,fontSize: 18)),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            cursorColor: Colors.white,
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: const TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
            style: (const TextStyle(color: Colors.white,fontSize: 18)),
            obscureText: true,
            obscuringCharacter: '*',
          ),
        ]));
  }

  _getLogIn(context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Вход',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500,color: Color(0xFFF4D5BC)),
          ),
          Container(
              child: IconButton(
                  onPressed: isButtonPressed == false
                      ? () async {
                          setState(() {
                            isButtonPressed = true;
                          });
                          List ans = await _loginButtonAction();
                          inProgress = false;
                          if (ans[0]) {
                            EasyLoading.show();
                            HomeInteractionState.selectedTab = 0;
                            ProductsData pd = ProductsData();
                            SharedPreferences _sp =
                                await SharedPreferences.getInstance();
                            LocalDataAnalyse _LDA = LocalDataAnalyse(sp: _sp);
                            await pd.parseData();
                            await pd.parseLikedProducts(ans[1]);
                            await pd.parseCartProducts(ans[1]);
                            _LDA.setLoginStatus(
                                "1",
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                            CurrentUserData.email =
                                _emailController.text.trim();
                            CurrentUserData.pass =
                                _passwordController.text.trim();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (r) => false);
                            EasyLoading.dismiss();
                            EasyLoading.removeAllCallbacks();
                            _emailController.clear();
                            _passwordController.clear();
                          } else if (inProgress == false) {
                            setState(() {
                              isButtonPressed = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Неверный логин или пароль!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.deepOrange,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            _passwordController.clear();
                          }
                        }
                      : null,
                  iconSize: 40,
                  icon: const Icon(Icons.arrow_forward,color: Color(0xFFF4D5BC)))),
        ],
      ),
    );
  }

  _getBottomRow(context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/register');
              _emailController.clear();
              _passwordController.clear();
            },
            child: const Text(
              'Регистрация',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/forpass');
                _emailController.clear();
                _passwordController.clear();
              },
              child: const Text(
                'Забыли пароль',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }
}

class BackgroundSignIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.black;
    canvas.drawPath(mainBackground, paint);

    // Blue
    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.5);
    blueWave.quadraticBezierTo(sw * 0.5, sh * 0.45, sw * 0.2, 0);
    blueWave.close();
    paint.color = Colors.black;
    canvas.drawPath(blueWave, paint);

    // Grey
    Path greyWave = Path();
    greyWave.lineTo(sw, 0);
    greyWave.lineTo(sw, sh * 0.1);
    greyWave.cubicTo(
        sw * 0.95, sh * 0.15, sw * 0.65, sh * 0.15, sw * 0.6, sh * 0.38);
    greyWave.cubicTo(sw * 0.52, sh * 0.52, sw * 0.05, sh * 0.45, 0, sh * 0.4);
    greyWave.close();
    paint.color = const Color(0xFF5B2C6F);
    canvas.drawPath(greyWave, paint);

    // Yellow
    Path yellowWave = Path();
    yellowWave.lineTo(sw * 0.7, 0);
    yellowWave.cubicTo(
        sw * 0.6, sh * 0.05, sw * 0.27, sh * 0.01, sw * 0.18, sh * 0.12);
    yellowWave.quadraticBezierTo(sw * 0.12, sh * 0.2, 0, sh * 0.2);
    yellowWave.close();
    paint.color = const Color(0xFF5B2C6F);
    canvas.drawPath(yellowWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
