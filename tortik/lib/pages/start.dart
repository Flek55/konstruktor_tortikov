import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}


class Start extends StatelessWidget{
  const Start({super.key});

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    initFireBase();//initializing the Database
        return Scaffold(
            backgroundColor: const Color(0xFF000000),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 120)),
                        const Image(image: AssetImage('assets/logo.jpg')),
                        const Text('Вкус французской\nклассики',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 25,
                              color: Color(0xFFF4D5BC)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('Сеть кондитерских Франсуа Бодреро в самом\n'
                            'центре Москвы',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Roboto',
                              fontSize: 13,
                              color: Color(0xFF707B7C)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 90)),
                        IconButton(
                          icon: const Icon(Icons.east),
                          iconSize: 65,
                          color: const Color(0xFFF4D5BC),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        ),]
                  ))
                ])
        );
  }
}