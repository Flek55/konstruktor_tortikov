import 'package:flutter/material.dart';
import 'package:tortik/Services/category_model.dart';
import 'package:tortik/Services/db_data.dart';

import '../../Services/server_data.dart';


class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  static List<Product> currentData = [];

  @override
  void initState() {
    currentData = ProductsData.bakeryData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child:
        Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
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
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return CategoryBox(category: CategoryModel.categories[index],updateData: (){
                  setState(() {
                    currentData = CategoryBox.tempData;
                  });
                },);
              },
            ),
          ),
          _getListView(),
        ],
      ),
    )));
  }
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
  ClipRRect(borderRadius: BorderRadius.circular(20),
      child: Stack(children: <Widget>[
        Positioned.fill(child:
        Container(decoration: const BoxDecoration(color:Color(0xFF5B2C6F)
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

_getListView(){
  return SizedBox(
      height: 300,
      child:
      ListView.builder(
        itemCount: _HomeMenuState.currentData.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(_HomeMenuState.currentData[index].name),
          );
        },
      ));
}

class CategoryBox extends StatefulWidget {
  final CategoryModel category;
  final Function updateData;
  static List<Product> tempData = [];

  const CategoryBox({Key? key, required this.category, required this.updateData}) : super(key: key);

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF5B2C6F),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child:
          Align(
            alignment: Alignment.center,
            child: InkWell(
              splashColor: Colors.white38,
              onTap: (){
                if (widget.category.id == 1){
                    CategoryBox.tempData = ProductsData.bakeryData;
                }else if(widget.category.id == 2){
                  CategoryBox.tempData = ProductsData.dessertsData;
                }else if(widget.category.id == 3){
                  CategoryBox.tempData = ProductsData.coffeeData;
                }else if(widget.category.id == 4){
                  CategoryBox.tempData = ProductsData.cakesData;
                }
              },
              child: Stack(children: [
                Text(widget.category.name,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Roboto',color: Colors.white),)
            ],
            ),)
          )
    );
  }
}
