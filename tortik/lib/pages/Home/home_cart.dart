import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/pages/Home/product_page.dart';
import 'package:tortik/pages/order_page.dart';

import '../../Services/db_data.dart';
import '../../Services/server_data.dart';
import 'home_interaction.dart';

class HomeCart extends StatefulWidget {
  const HomeCart({Key? key}) : super(key: key);

  @override
  State<HomeCart> createState() => HomeCartState();
}

class HomeCartState extends State<HomeCart> {
  static List<Product> cartProducts = [];
  static List<Map<String, dynamic>> cartAmount = [];
  static List<Product> ans = [];
  static List<Map<String, dynamic>> cart = [];
  DataGetter dg = DataGetter();
  ProductsData pd = ProductsData();
  static bool inProgress = false;
  static bool orderSwitch = false;
  static bool buttonClick = false;
  static bool showAddressField = false;
  final _addressController = TextEditingController();

  @override
  void initState() {
    cartProducts = compressCartProducts();
    cartAmount = compressAmount();
    cart = compressCart();
    inProgress = false;
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  List<Map<String, dynamic>> compressCart() {
    List<Map<String, dynamic>> ans = [];
    for (int i = 0; i < cartProducts.length; i++) {
      for (int j = 0; j < cartAmount.length; j++) {
        if (cartProducts[i].id == cartAmount[j]["product_id"]) {
          ans.add({
            "id": cartProducts[i].id,
            "amount": cartAmount[j]["amount"],
            "name": cartProducts[i].name,
            "price": cartProducts[i].price,
            "description": cartProducts[i].description,
          });
        }
      }
    }
    setState(() {});
    return ans;
  }

  static List<Product> compressCartData2() {
    List<String> ids = [];
    cart.clear();
    for (int i = 0; i < ProductsData.cartData.length; i++) {
      ids.add(ProductsData.cartData[i].product_id.toString());
    }
    getElementsAppearInBothList(ids, ProductsData.dataset, ans);
    return ans;
  }

  static void getElementsAppearInBothList(List<String> l1, List<Product> l2,
      List<Product> ans) {
    for (int i = 0; i < l2.length; i++) {
      for (int j = 0; j < l1.length; j++) {
        if (l2[i].id.toString() == l1[j]) {
          ans.add(l2[i]);
        }
      }
    }
  }

  static List<Map<String, dynamic>> compressAmount() {
    List<Map<String, dynamic>> data = ProductsData.cartAmountsPD;
    return data;
  }

  static List<Product> compressCartProducts() {
    List<String> ids = [];
    cartProducts.clear();
    for (int i = 0; i < ProductsData.cartData.length; i++) {
      ids.add(ProductsData.cartData[i].product_id.toString());
    }
    getElementsAppearInBothList(ids, ProductsData.dataset, ans);
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                Row(children: [
                  const Padding(padding: EdgeInsets.only(top: 50, left: 40)),
                  Text('Ваш заказ \nвсегда под рукой!',
                      textAlign: TextAlign.left,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 24)),
                ]),
                const Padding(padding: EdgeInsets.only(top: 20)),
                _getListView(),
                const Padding(padding: EdgeInsets.only(top: 30)),
                _getOrderButton(),
                const Padding(padding: EdgeInsets.only(top: 30)),
                _getAddressField(context, _addressController),
              ]),
            )));
  }

  _getProductPush(url) {
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              ProductPage(
                notifyParent: refresh,
                imageURL: url,
              ),
        ));
  }

  _getListView() {
    if (cartProducts.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: cartProducts.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: ListTile(
              onTap: () async {
                ProductsData.selectedProductId = cartProducts[index].id;
                HomeInteractionState.selectedTab = 2;
                DataGetter dg = DataGetter();
                String url =
                await dg.getProductImageURL(ProductsData.selectedProductId);
                _getProductPush(url);
              },
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(
                "${cartProducts[index].name}",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 16.5),
              ),
              subtitle: Text(
                "${cartProducts[index].description}\n₽${cartProducts[index]
                    .price}", style: Theme
                  .of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 12),),
              trailing: Wrap(spacing: 12, children: [
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          if (!inProgress) {
                            inProgress = true;
                            DataGetter dg = DataGetter();
                            await dg.configureCart(cartProducts[index].id, "+");
                            ProductsData pd = ProductsData();
                            await pd.parseCartProducts(
                                FirebaseAuth.instance.currentUser?.uid);
                            inProgress = false;
                            cartProducts = compressCartProducts();
                            cartAmount = compressAmount();
                            cart = compressCart();
                            refresh;
                            setState(() {});
                            inProgress = false;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Icon(Icons.add, color: Colors.black,),
                        ))),
                SizedBox(
                  height: 23,
                  width: 16,
                  child: Text(
                      "${cart[index]["amount"]}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 18),
                  ),
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          if (inProgress == false) {
                            inProgress = true;
                            DataGetter dg = DataGetter();
                            await dg.configureCart(cart[index]["id"], "-");
                            ProductsData pd = ProductsData();
                            await pd.parseCartProducts(
                                FirebaseAuth.instance.currentUser?.uid);
                            cartProducts = compressCartProducts();
                            cartAmount = compressAmount();
                            cart = compressCart();
                            inProgress = false;
                            setState(() {});
                            refresh;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Icon(Icons.remove, color: Colors.black,),
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
      return const Column(children: [
        SizedBox(
          height: 100,
          width: 300,
          child: Text("Корзина пуста"),
        ),
      ]);
    }
  }

  refreshOrder() async {
    DataGetter dg = DataGetter();
    ProductsData pd = ProductsData();
    HomeInteractionState.selectedTab = 2;
    await dg.clearCart();
    await pd.parseCartProducts(FirebaseAuth.instance.currentUser?.uid);
    cartProducts = compressCartProducts();
    cartAmount = compressAmount();
    cart = compressCart();
    setState(() {});
  }

  _getPushNamed(String address) {
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                OrderPage(
                  notifyParent: refreshOrder,
                  input: cart,
                  address: address,
                )));
  }

  _getAddressField(context, displayNameController) {
    return Visibility(
        visible: showAddressField,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: displayNameController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (_addressController.text.trim() != "" &&
                        _addressController.text.length >= 2 &&
                        !orderSwitch) {
                      orderSwitch = true;
                      ProductsData pd = ProductsData();
                      await pd.parseCartProducts(
                          FirebaseAuth.instance.currentUser?.uid);
                      DataGetter dg = DataGetter();
                      await dg.createOrder(
                          cartProducts, _addressController.text.trim());
                      _getPushNamed(_addressController.text.trim());
                      setState(() {
                        showAddressField = false;
                      });
                      await refreshOrder();
                      _addressController.clear();
                      orderSwitch = true;
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: "Адрес доставки",
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide:
                  BorderSide(color: Theme
                      .of(context)
                      .colorScheme
                      .tertiary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary),
                ),
              ),
              style: (const TextStyle(color: Colors.black, fontSize: 18)),
            )));
  }

  _getOrderButton() {
    if (cartProducts.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  setState(() {
                    showAddressField = !showAddressField;
                  });
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 12)),
                  ),
                )),
          ),
        ],
      );
    } else {
      return const Padding(padding: EdgeInsets.only(top: 0));
    }
  }
}
