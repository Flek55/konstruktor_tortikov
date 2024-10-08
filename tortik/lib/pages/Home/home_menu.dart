import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/Services/category_model.dart';
import 'package:tortik/Services/db_data.dart';
import 'package:tortik/pages/Home/product_page.dart';
import 'package:tortik/pages/search_result.dart';

import '../../Services/server_data.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => HomeMenuState();
}

class HomeMenuState extends State<HomeMenu> {
  static List<Product> currentData = [];
  final _searchController = TextEditingController();

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
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                  child: Text("Как нас найти?",
                      style: Theme.of(context).textTheme.displayMedium),
                )
              ]),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Row(children: [
                const Padding(padding: EdgeInsets.only(top: 50, left: 40)),
                Text('Отличный кофе\nВсегда и везде!',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 24))
              ]),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 360,
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: _searchController,
                  style: (const TextStyle(color: Colors.black, fontSize: 20)),
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          String input = _searchController.text.trim();
                          if (input.isNotEmpty) {
                            input = input.replaceFirst(
                                input[0], input[0].toUpperCase());
                            QuerySnapshot ansBakery = await FirebaseFirestore
                                .instance
                                .collection("products")
                                .doc("bakery")
                                .collection("menu")
                                .where("name",
                                    isGreaterThanOrEqualTo: input.trim())
                                .where("name", isLessThan: '${input.trim()}я')
                                .get();
                            QuerySnapshot ansDesserts = await FirebaseFirestore
                                .instance
                                .collection("products")
                                .doc("desserts")
                                .collection("menu")
                                .where("name",
                                    isGreaterThanOrEqualTo: input.trim())
                                .where("name", isLessThan: '${input.trim()}я')
                                .get();
                            QuerySnapshot ansCakes = await FirebaseFirestore
                                .instance
                                .collection("products")
                                .doc("cakes")
                                .collection("menu")
                                .where("name",
                                    isGreaterThanOrEqualTo: input.trim())
                                .where("name", isLessThan: '${input.trim()}я')
                                .get();
                            QuerySnapshot ansCoffee = await FirebaseFirestore
                                .instance
                                .collection("products")
                                .doc("coffee")
                                .collection("menu")
                                .where("name",
                                    isGreaterThanOrEqualTo: input.trim())
                                .where("name", isLessThan: '${input.trim()}я')
                                .get();
                            List list = ansBakery.docs +
                                ansDesserts.docs +
                                ansCoffee.docs +
                                ansCakes.docs;
                            var ans = list
                                .map((item) => Product(
                                    id: item.id,
                                    name: item["name"],
                                    price: item["price"],
                                    description: item["description"]))
                                .toList();
                            _getPushNamed(ans);
                          }
                          ;
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
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

  _getPushNamed(data) {
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => SearchResultPage(
                  data: data,
                )));
  }

  _getProductPush(url) {
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ProductPage(
            notifyParent: refresh,
            imageURL: url,
          ),
        ));
  }

  _getListView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: HomeMenuState.currentData.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: ListTile(
                onTap: () async {
                  ProductsData.selectedProductId =
                      HomeMenuState.currentData[index].id;
                  DataGetter dg = DataGetter();
                  String url = await dg
                      .getProductImageURL(ProductsData.selectedProductId);
                  _getProductPush(url);
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(
                  HomeMenuState.currentData[index].name,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 16.5),
                ),
                subtitle: Text(
                  "${HomeMenuState.currentData[index].description}\n₽${HomeMenuState.currentData[index].price}",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 12),
                ),
                trailing: Wrap(children: [
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () async {
                            DataGetter dg = DataGetter();
                            await dg.configureCart(
                                HomeMenuState.currentData[index].id, "+");
                            ProductsData pd = ProductsData();
                            await pd.parseCartProducts(
                                FirebaseAuth.instance.currentUser?.uid);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ))),
                ])));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(padding: EdgeInsets.only(top: 10));
      },
    );
  }
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
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white38,
              onTap: () {
                if (widget.category.id == 1) {
                  HomeMenuState.currentData = ProductsData.bakeryData;
                  widget.notifyParent();
                } else if (widget.category.id == 2) {
                  HomeMenuState.currentData = ProductsData.dessertsData;
                  widget.notifyParent();
                } else if (widget.category.id == 3) {
                  HomeMenuState.currentData = ProductsData.coffeeData;
                  widget.notifyParent();
                } else if (widget.category.id == 4) {
                  HomeMenuState.currentData = ProductsData.cakesData;
                  widget.notifyParent();
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Text(widget.category.name,
                        style: Theme.of(context).textTheme.displaySmall)
                  ],
                ),
              ),
            )));
  }
}
