import 'package:flutter/material.dart';
import 'package:tortik/pages/start.dart';
import 'package:tortik/pages/home.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Start(),
    '/home': (context) => const Home(),
  },
));
