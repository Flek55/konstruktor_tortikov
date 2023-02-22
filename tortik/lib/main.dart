import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //final ColorScheme colors = Theme.of(context).colorScheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  child: IconButton(
                    icon: const Icon(Icons.filter_drama),
                    iconSize: 65,
                    onPressed: () {},
                    style: IconButton.styleFrom(
                    ),
                  )
              ),]
        )
    ])
      )
    );
  }
}