import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}
List _names = [
  Row(children: const [
    Padding(padding: EdgeInsets.only(left: 50)),
    Text('Десерты',textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Roboto',fontSize: 15,color: Colors.black)),
    SizedBox(width: 35,),
    Text( "Кофе",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Roboto',fontSize: 15,color: Colors.black)),
    SizedBox(width: 35,),
    Text("Выпечка",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Roboto',fontSize: 15,color: Colors.black)),
    SizedBox(width: 35,),
    Text("Торты",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Roboto',fontSize: 15,color: Colors.black))
  ])];

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(children: const [
            Padding(padding: EdgeInsets.only(top: 50, left: 40)),
            Text('Отличный кофе\nВсегда и везде!',
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: 'Roboto',
                  fontSize: 25,
                  color: Colors.black
              ),)
          ]
          ),

          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(4),
              itemCount: 1,
              itemBuilder: (context,index){
                return _names[index];
              },
              separatorBuilder: (context,index){
                return const SizedBox(width: 50);
              },
            ),
          ),
          const TextField(
            decoration: InputDecoration(
                labelText: 'Введите название десерта',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),)),
            style: (TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );}}