import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tortik/pages/register.dart';
import 'package:tortik/pages/start.dart';
import 'package:tortik/pages/home_interaction.dart';
import 'package:tortik/pages/logreg.dart';
import 'package:tortik/pages/forgetpass.dart';
import 'package:tortik/pages/log.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
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
}

Future<bool> initFireBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return true;
}