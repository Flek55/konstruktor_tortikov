import 'package:flutter/material.dart';
import 'package:tortik/pages/register.dart';
import 'package:tortik/pages/start.dart';
import 'package:tortik/pages/home.dart';
import 'package:tortik/pages/login.dart';
import 'package:tortik/pages/log.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Start(),
    '/home': (context) => const Home(),
    '/logger': (context) => const LogReg(),
    '/register': (context) => const SignUpPage(),
    '/login': (context) => const LoginPage(),
  },
));
