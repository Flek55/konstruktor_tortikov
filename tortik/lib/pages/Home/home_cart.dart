import 'package:flutter/material.dart';

class HomeCart extends StatefulWidget {
  const HomeCart({Key? key}) : super(key: key);

  @override
  State<HomeCart> createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Корзина"),
      ),
    );
  }
}
