import 'package:flutter/material.dart';

class LogReg extends StatefulWidget {
  const LogReg({Key? key}) : super(key: key);

  @override
  State<LogReg> createState() => _LogRegState();
}

class _LogRegState extends State<LogReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(painter:BackgroundLogReg(),child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 120)),
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.login,
              size: 150,
              color: Color(0xFFF4D5BC),
            ),
          ]),
          const Padding(padding: EdgeInsets.only(top: 80)),
          Text(
            'Регистация и\nвход',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 35,color: const Color(0xFFF4D5BC),)
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
          SizedBox(
            height: 40,
            width: 150,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF5B2C6F))),
              child: const Text(
                'Регистрация',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF4D5BC),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          SizedBox(
            height: 40,
            width: 150,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF5B2C6F))),
              child: const Text(
                'Вход',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF4D5BC),
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      )
      ),
    );
  }
}
class BackgroundLogReg extends CustomPainter {
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
  
