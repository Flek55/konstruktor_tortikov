import 'package:flutter/material.dart';


class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}
List _names = [Row(children:[
  const SizedBox(width: 20),
  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
                    decoration: const BoxDecoration(
                        color:Color(0xFF5B2C6F)
                    ))),
            TextButton(onPressed:(){},style:TextButton.styleFrom(foregroundColor: Colors.white30,
                padding: const EdgeInsets.all(16),textStyle: const TextStyle(fontSize: 18)),
                child: const Text("Выпечка",style:TextStyle(color: Colors.white)))
          ])),
  const SizedBox(width: 30),
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
            ), TextButton(onPressed:(){},
                style:TextButton.styleFrom(foregroundColor: Colors.white30,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 18)),
                child: const Text("Десерты",style:TextStyle(color: Colors.white)))
          ])),
  const SizedBox(width: 30),
  ClipRRect(borderRadius: BorderRadius.circular(20),child: Stack(children: <Widget>[Positioned.fill(child: Container(decoration: const BoxDecoration(color:Color(0xFF5B2C6F)
  )
  )
  ),
    TextButton(onPressed:(){},
        style:TextButton.styleFrom(foregroundColor: Colors.white30,
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(fontSize: 18)),
        child: const Text("Кофе",style:TextStyle(color: Colors.white)))
  ]
  )
  ),
  const SizedBox(width: 30),ClipRRect(
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
            TextButton(onPressed:(){},
                style:TextButton.styleFrom(foregroundColor: Colors.white30,
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 18)),
                child:const Text("Торты",style:TextStyle(color: Colors.white)))
          ]
      )
  )
]
)
];



class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const Icon(Icons.place),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/map');
            }, child: const Text("Как нас найти?",style:
            TextStyle(color: Colors.black, fontSize: 17)),)
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
          SizedBox(height: 40,width: 360,child:TextField(
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed:(){} , icon: const Icon(Icons.arrow_forward)) ,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Color(0xFF5B2C6F)),
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