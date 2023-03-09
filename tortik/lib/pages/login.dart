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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top:120)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:const [
              Icon(Icons.login,
                size: 150 ,
                color: Color(0xFFF4D5BC),
              ),
            ]
            ),
          const Padding(padding: EdgeInsets.only(top: 80)),
          const Text('Регистация и\nвход',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF4D5BC),
              fontSize: 30,
              fontFamily: 'Roboto',
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
          SizedBox(
            height: 40,
            width: 150,
          child: TextButton(onPressed: () {
            Navigator.pushReplacementNamed(context,'/register');
          },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF5B2C6F))
            ),
              child:
                const Text('Регистрация',
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF4D5BC),
                    fontSize: 15,
                ),
              ),
          ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          SizedBox(
            height: 40,
            width: 150,
            child: TextButton(onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF5B2C6F))
              ),
              child:
              const Text('Вход',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF4D5BC),
                  fontSize: 15,
              ),
            ),
          ),)
        ],
      ),
    );
  }
}