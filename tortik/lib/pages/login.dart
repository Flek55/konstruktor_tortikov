import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              //Padding(padding: EdgeInsets.only(left: 80)),
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
            Navigator.pushNamed(context,'/register');
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
              Navigator.pushNamed(context, '/home');
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

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}

