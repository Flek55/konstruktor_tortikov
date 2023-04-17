import 'package:flutter/material.dart';

class HomeCart extends StatefulWidget {
  const HomeCart({Key? key}) : super(key: key);

  @override
  State<HomeCart> createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: const [],
          ),
          Row(children: const [
            Padding(padding: EdgeInsets.only(top: 50, left: 40)),
            Text('Ваш заказ \nвсегда под рукой!',
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: 'Roboto',
                fontSize: 25,
                color: Colors.black,
              ),)]
          ),
        ],
      ),
    );
  }
}