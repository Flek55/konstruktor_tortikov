import 'package:flutter/material.dart';
import 'package:tortik/pages/register.dart';
import 'package:tortik/pages/start.dart';
import 'package:tortik/pages/home_interaction.dart';
import 'package:tortik/pages/logreg.dart';
import 'package:tortik/pages/forgetpass.dart';
import 'package:tortik/pages/log.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Start(),
    '/home': (context) => const HomeInteraction(),
    '/logger': (context) => const LogReg(),
    '/register': (context) => const SignUpPage(),
    '/forpass': (context) => const ForgetPass(),
    '/login': (context) => const LoginPage(),
  },
));