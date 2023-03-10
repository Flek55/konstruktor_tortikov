import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State {
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
                  _getInputs(),
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
  //Future signIn() async {
  //  await FirebaseAuth.instance.signInWithEmailAndPassword(
  //      email: emailController.text.trim(),
  //      password: passwordController.text.trim(),
  //  );
  //}
}

_getHeader() {
  return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomLeft,
      child:const Text(
        'Регистрация аккаунта',
        style: TextStyle(color: Colors.white, fontSize: 37),
      ),
    ),
  );
}

_getInputs() {
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            labelText: 'Имя',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Пароль',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
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
      children:<Widget>[
        const Text(
          'Регистрация',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        Container(
            color: Colors.black12,
            child: IconButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
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
            Navigator.pushNamed(context,'/login');
          },
          child:  const Text("Вход",
              style: TextStyle(
                color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
              ),
            ),
      ],
    ),
  );
}

class BackgroundSignUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.grey.shade100;
    canvas.drawPath(mainBackground, paint);

    // Blue
    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.65);
    blueWave.cubicTo(sw * 0.8, sh * 0.8, sw * 0.5, sh * 0.8, sw * 0.45, sh);
    blueWave.lineTo(0, sh);
    blueWave.close();
    paint.color = Colors.lightBlue.shade300;
    canvas.drawPath(blueWave, paint);

    // Grey
    Path greyPath = Path();
    greyPath.lineTo(sw, 0);
    greyPath.lineTo(sw, sh * 0.3);
    greyPath.cubicTo(sw * 0.65, sh * 0.45, sw * 0.25, sh * 0.35, 0, sh * 0.5);
    greyPath.close();
    paint.color = Colors.grey.shade800;
    canvas.drawPath(greyPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}