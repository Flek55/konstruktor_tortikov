import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}
List _names = [Row(children:[
  SizedBox(width: 20),
  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
                    decoration: const BoxDecoration(
                        color:Color(0xFF5B2C6F)
                    ))),
            TextButton(onPressed:(null), child: const Text("Торты",style:TextStyle(color: Colors.white)),style:TextButton.styleFrom(foregroundColor: Colors.white30,padding: const EdgeInsets.all(16),textStyle: const TextStyle(fontSize: 18)))
          ])),
  const SizedBox(width: 60),
  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF5B2C6F)
                ),
              ),
            ), TextButton(onPressed:(null), child: const Text("Десерты",style:TextStyle(color: Colors.white)),style:TextButton.styleFrom(foregroundColor: Colors.white30,padding: const EdgeInsets.all(16),textStyle: const TextStyle(fontSize: 18)))
          ])),
  const SizedBox(width: 60),
  ClipRRect(borderRadius: BorderRadius.circular(20),child: Stack(children: <Widget>[Positioned.fill(child: Container(decoration: const BoxDecoration(color:Color(0xFF5B2C6F)
  ))),
    TextButton(onPressed:(null), child: const Text("Кофе",style:TextStyle(color: Colors.white)),style:TextButton.styleFrom(foregroundColor: Colors.white30,padding: const EdgeInsets.all(16),textStyle: const TextStyle(fontSize: 18)))
  ])),
  const SizedBox(width: 60),ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    color:Color(0xFF5B2C6F)
                ),
              ),
            ),
            TextButton(onPressed:(null), child:Text("Выпечка",style:TextStyle(color: Colors.white)),style:TextButton.styleFrom(foregroundColor: Colors.white30,padding: const EdgeInsets.all(16),textStyle: const TextStyle(fontSize: 18)))
          ]))]
)];



class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row( children:const [
            Padding(padding: EdgeInsets.only(left: 10)),
            IconButton(onPressed: null, icon: Icon(Icons.account_circle,size: 30,)),
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(Icons.place),
            TextButton(onPressed: null, child: Text("Как нас найти?"))
          ]
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
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
          const SizedBox(height: 30,),
          const SizedBox(height: 40,width: 360,child:TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              suffixIcon: IconButton(onPressed:null , icon: Icon(Icons.arrow_forward)) ,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ), ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(4),
              itemCount: 1,
              itemBuilder: (context,index){
                return _names[index];
              },
              separatorBuilder: (context,index){
                return const SizedBox(width: 150);
              },
            ),
          ),
        ],
      ),
    );}}