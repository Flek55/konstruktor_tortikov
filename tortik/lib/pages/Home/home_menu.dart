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

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.place),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  child: const Text("Как нас найти?",
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                )
              ]),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Row(children: const [
                Padding(padding: EdgeInsets.only(top: 50, left: 40)),
                Text(
                  'Отличный кофе\nВсегда и везде!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 25, color: Colors.black),
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 360,
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward)),
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
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CategoryBox(
                        category: CategoryModel.categories[index],
                        notifyParent: refresh);
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              _getListView(),
            ],
          ),
        )));
  }
}

_getListView() {
  return ListView.separated(
    shrinkWrap: true,
    itemCount: _HomeMenuState.currentData.length,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(_HomeMenuState.currentData[index].name),
        trailing: const Icon(Icons.add),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const Padding(padding: EdgeInsets.only(top: 40));
    },
  );
}

class CategoryBox extends StatefulWidget {
  final CategoryModel category;
  final Function() notifyParent;

  const CategoryBox(
      {Key? key, required this.category, required this.notifyParent})
      : super(key: key);

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
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white38,
              onTap: () {
                if (widget.category.id == 1) {
                  _HomeMenuState.currentData = ProductsData.bakeryData;
                  widget.notifyParent();
                } else if (widget.category.id == 2) {
                  _HomeMenuState.currentData = ProductsData.dessertsData;
                  widget.notifyParent();
                } else if (widget.category.id == 3) {
                  _HomeMenuState.currentData = ProductsData.coffeeData;
                  widget.notifyParent();
                } else if (widget.category.id == 4) {
                  _HomeMenuState.currentData = ProductsData.cakesData;
                  widget.notifyParent();
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Text(
                      widget.category.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )));
  }
}
