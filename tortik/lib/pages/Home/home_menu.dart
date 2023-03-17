import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 70)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(left: 40)),
              IconButton(onPressed: () {

              },
                  icon: const Icon(Icons.account_circle, size: 40,),
                  padding: EdgeInsets.zero,),
              const Padding(padding: EdgeInsets.only(left: 80)),
              const Text("Adress", style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),),//TODO: найти виджет и сделать карту
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(children: const [
            Padding(padding: EdgeInsets.only(top: 50, left: 40)),
            Text('Отличный кофе\nВсегда и везде!',
              textAlign: TextAlign.center,
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