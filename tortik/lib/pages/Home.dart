import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Expanded(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 300)),
                        //const Image(image: AssetImage('assets/logo.jpg')),
                        const Text('Bodrero',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'MarckScript',
                              fontSize: 90,
                              color: Color(0xFFD1BC8A)),
                        ),
                        const Divider(
                          color: Color(0xFFA569BD),
                          thickness: 4,
                          indent: 100,
                          endIndent: 100,
                        ),
                        const Text('depuis 1986',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'MarckScript',
                              fontSize: 25,
                              color: Color(0xFFD1BC8A)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                        const Text('Вкус французской\nклассики',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 25,
                              color: Color(0xFFD1BC8A)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('Сеть кондитерских Франсуа Бодреро в самом\n'
                            'центре Москвы',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 13,
                              color: Color(0xFF707B7C)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 80)),
                        IconButton(
                          icon: const Icon(Icons.east),
                          iconSize: 65,
                          color: const Color(0xFFD1BC8A),
                          onPressed: () {},
                        ),]
                  ))
                ])
        )
    );
  }
}