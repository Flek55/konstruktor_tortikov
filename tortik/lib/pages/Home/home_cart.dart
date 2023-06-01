import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Services/db_data.dart';
import '../../Services/server_data.dart';
import 'home_interaction.dart';


class HomeCart extends StatefulWidget {
  const HomeCart({Key? key}) : super(key: key);

  @override
  State<HomeCart> createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCart> {
  static List<Product> cartData = [];
  List<Product> ans = [];
  DataGetter dg = DataGetter();

  @override
  void initState() {
    cartData = compressCart();
    super.initState();
  }

  List<Product> compressCart() {
    List<String> ids = [];

    for (int i = 0; i < ProductsData.cartData.length; i++) {
      ids.add(ProductsData.cartData[i].product_id.toString());
    }
    getElementsAppearInBothList(ids, ProductsData.dataset, ans);
    return ans;
  }

  void getElementsAppearInBothList(
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
          child: Column(
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B2C6F),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Сделать заказ"),
                          ),
                        )),
                  ),
                ],
              )
            ]
          ),
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
                  Navigator.pushReplacementNamed(context, '/product_info');
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text("${cartData[index].name}"),
                subtitle: Text(
                    "${cartData[index].description} ₽${cartData[index].price}"),
                trailing: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          DataGetter dg = DataGetter();
                          await dg.configureCart(cartData[index].id,"+");
                          ProductsData pd = ProductsData();
                          await pd.parseCartProducts(FirebaseAuth.instance.currentUser?.uid);
                          setState(() {
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Icon(Icons.add),
                        ))),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(top: 10));
        },
      );
    } else {
      return Container(
        height: 100,
        width: 300,
        child: Text("Корзина пуста"),
      );
    }
  }
}
