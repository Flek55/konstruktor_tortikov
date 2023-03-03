import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tortik/pages/start.dart';
import 'package:tortik/pages/home.dart';
import 'package:tortik/pages/login.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Start(),
    '/home': (context) => const Home(),
    '/loginPage': (context) => const LoginPage(),
    '/register': (context) => const Register(),
    '/login': (context) => const Login(),
  },
));
