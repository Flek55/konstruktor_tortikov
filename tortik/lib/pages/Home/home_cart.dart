import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/pages/Home/product_page.dart';

import '../../Services/db_data.dart';
import '../../Services/server_data.dart';
import 'home_interaction.dart';

class HomeCart extends StatefulWidget {
  const HomeCart({Key? key}) : super(key: key);

  @override
  State<HomeCart> createState() => HomeCartState();
}

class HomeCartState extends State<HomeCart> {
  static List<Product> cartData = [];
  static List<Product> ans = [];
  DataGetter dg = DataGetter();
  ProductsData pd = ProductsData();
  static bool inProgress = false;
  static bool orderSwitch = false;

  @override
  void initState() {
    cartData = compressCart();
    inProgress = false;
    super.initState();
  }

  refresh(){
    setState(() {

    });
  }

  static List<Product> compressCart() {
    List<String> ids = [];
    cartData.clear();
    for (int i = 0; i < ProductsData.cartData.length; i++) {
      ids.add(ProductsData.cartData[i].product_id.toString());
    }
    getElementsAppearInBothList(ids, ProductsData.dataset, ans);
    return ans;
  }

  static void getElementsAppearInBothList(
      List<String> l1, List<Product> l2, List<Product> ans) {
    for (int i = 0; i < l2.length; i++) {
      for (int j = 0; j < l1.length; j++) {
        if (l2[i].id.toString() == l1[j]) {
          ans.add(l2[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Row(children: [
              Padding(padding: EdgeInsets.only(top: 50, left: 40)),
              Text(
                'Ваш заказ \nвсегда под рукой!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  color: Colors.black,
                ),
              )
            ]),
            const Padding(padding: EdgeInsets.only(top: 20)),
            _getListView(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _getOrderButton(),
          ]),
        )));
  }

  _getListView() {
    if (cartData.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: cartData.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: ListTile(
                onTap: () {
                  ProductsData.selectedProductId = cartData[index].id;
                  HomeInteractionState.selectedTab = 2;
                  Navigator.push(context,
                      MaterialPageRoute<void>(
                      builder: (BuildContext context) =>  ProductPage(notifyParent: refresh)));
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text("${cartData[index].name}",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16.5),),
                subtitle: Text(
                    "${cartData[index].description}\n ₽${cartData[index].price}"),
                trailing: Wrap(spacing: 12, children: [
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () async {
                            DataGetter dg = DataGetter();
                            await dg.configureCart(cartData[index].id, "+");
                            ProductsData pd = ProductsData();
                            await pd.parseCartProducts(
                                FirebaseAuth.instance.currentUser?.uid);
                            inProgress = false;
                            refresh;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Icon(Icons.add),
                          ))),
                  Container(
                    height: 20,
                    width: 20,
                    child: Text(""),
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () async {
                            if(inProgress == false) {
                              DataGetter dg = DataGetter();
                              await dg.configureCart(cartData[index].id, "-");
                              ProductsData pd = ProductsData();
                              await pd.parseCartProducts(
                                  FirebaseAuth.instance.currentUser?.uid);
                              ans.clear();
                              cartData.clear();
                              cartData = HomeCartState.compressCart();
                              inProgress = false;
                              setState(() {

                              });
                              refresh;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Icon(Icons.remove),
                          )))
                ]),
              ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(top: 10));
        },
      );
    } else {
      return Column(children:[
        Container(
        height: 100,
        width: 300,
        child: Text("Корзина пуста"),
      ),
      ]);
    }
  }

  _getPushNamed(){
    return Navigator.pushNamed(context, "/order");
  }

  _getOrderButton(){
    if (cartData.isNotEmpty){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () async {
                  if (!orderSwitch) {
                    orderSwitch = true;
                    ProductsData pd = ProductsData();
                    await pd.parseCartProducts(
                        FirebaseAuth.instance.currentUser?.uid);
                    DataGetter dg = DataGetter();
                    await dg.createOrder(cartData);
                    _getPushNamed();
                    cartData.clear();
                    orderSwitch = false;
                  }
                },
                child: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B2C6F),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Сделать заказ",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 12)),
                  ),
                )),
          ),
        ],
      );
    }else{
      return const Padding(padding: EdgeInsets.only(top: 0));
    }
  }
}
