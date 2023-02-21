import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: Container(
          margin: const EdgeInsets.only(top: 300),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Bodrero',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'MarckScript',
                  fontSize: 70,
                  color: Color(0xFFD1BC8A)),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50.0),
                  child: TextButton(onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF4A235A)),
                  child: const Text('→',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, color: Color(0xFFD1BC8A)),
                  )
              )
            ),]
        )
    )
      )
    );
  }
}