import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/favorite_product.dart';
import 'package:tortik/Services/server_data.dart';
import 'package:tortik/pages/Home/home_cart.dart';

import 'cart_data.dart';

class ProductsData {
  static List<Product> dataset = [];
  static String selectedProductId = "";
  static List<Product> bakeryData = [];
  static List<Product> dessertsData = [];
  static List<Product> cakesData = [];
  static List<Product> coffeeData = [];
  static List<FavoriteProduct> favoriteDataPD = [];
  static List<CartProduct> cartData = [];
  static List<Map<String, dynamic>> cartAmountsPD = [];

  Future<int> parseData() async {
    final DataGetter dg = DataGetter();
    bakeryData = await dg._getDataBakery();
    dessertsData = await dg._getDataDesserts();
    cakesData = await dg._getDataCakes();
    coffeeData = await dg._getDataCoffee();
    dataset = await dg._getDataSet();
    return 0;
  }

  Future<int> parseLikedProducts(user_id) async {
    final DataGetter dg = DataGetter();
    favoriteDataPD.clear();
    favoriteDataPD = await dg._getFavorites(user_id);
    return 0;
  }

  Future<int> parseCartProducts(user_id) async {
    final DataGetter dg = DataGetter();
    cartData.clear();
    cartData = await dg.getCart(user_id);
    cartAmountsPD = await dg.getProductsAmount();
    return 0;
  }
}

class DataGetter {
  Map<String, dynamic> currentProduct = {};
  List<Product> dataset = [];
  List<Product> bakeryData = [];
  List<Product> dessertsData = [];
  List<Product> cakesData = [];
  List<Product> coffeeData = [];
  List<FavoriteProduct> favoriteData = [];
  List<CartProduct> cartData = [];
  Map<String, dynamic> cartAmounts = {};
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<int> clearCart() async {
    var cart = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("cart");
    await getCart(_fAuth.currentUser?.uid);
    for (int i = 0; i < cartData.length; i++) {
      if (cartData[i].product_id != "0") {
        cart.doc(cartData[i].product_id).delete();
      }
    }
    return 0;
  }

  Future<List<Map<String, dynamic>>> getProductsAmount() async {
    var records = await FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("cart")
        .get();
    List zhopa = records.docs;
    List<Map<String, dynamic>> ans = [];
    for (int i = 0; i < zhopa.length; i++) {
      ans.add(zhopa[i].data());
    }
    return ans;
  }

  Future<List<Map<String, dynamic>>> getOrder(orderId) async {
    List<Map<String, dynamic>> ans = [];
    QuerySnapshot<Map<String, dynamic>> ds = await FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .doc(orderId)
        .collection("menu")
        .get();
    for (int j = 0; j < ds.docs.length; j++) {
      Map<String, dynamic> temp = ds.docs[j].data();
      ans.add(temp);
    }
    return ans;
  }

  Future<List<List<Map<String, dynamic>>>> orderList() async {
    List<List<Map<String, dynamic>>> ans = [];
    QuerySnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .get();
    for (int i = 0; i < docRef.docs.length; i++) {
      ans.add(await getOrder(docRef.docs[i].id));
    }
    return ans;
  }

  Future<List<String>> getOrderIds() async{
    List<String> ans = [];
    QuerySnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .get();
    for (int i = 0; i < docRef.docs.length; i++){
      ans.add(docRef.docs[i].id);
    }
    return ans;
  }

  Future<int> createOrder(cart_list, String address) async {
    String ids = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .doc()
        .id;
    FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .doc(ids)
        .set({"address": address});
    var order = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("orders")
        .doc(ids)
        .collection("menu");
    cartData.clear();
    cartData = await getCart(_fAuth.currentUser?.uid);
    List<Product> temp = getElementsAppearInBothList(cartData, cart_list);
    for (int i = 0; i < temp.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(_fAuth.currentUser?.uid)
          .collection("cart")
          .doc(temp[i].id)
          .get();
      Map mappedDoc = doc.data()!;
      await order.doc(temp[i].id).set({
        "product_id": temp[i].id,
        "amount": mappedDoc["amount"],
        "product_name": temp[i].name.toString()
      });
    }
    return 0;
  }

  static List<Product> getElementsAppearInBothList(
      List<CartProduct> l1, List<Product> l2) {
    List<Product> ans = [];
    for (int i = 0; i < l2.length; i++) {
      for (int j = 0; j < l1.length; j++) {
        if (l2[i].id.toString() == l1[j].product_id.toString()) {
          ans.add(l2[i]);
        }
      }
    }
    return ans;
  }

  Future<int> configureLikedProduct(product_id) async {
    var docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("favorites")
        .doc(product_id);
    docRef.get().then((doc) async => {
          if (doc.exists)
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("favorites")
                  .doc(product_id)
                  .delete()
            }
          else
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("favorites")
                  .doc(product_id)
                  .set({"product_id": product_id})
            }
        });
    ProductsData pd = ProductsData();
    await pd.parseLikedProducts(_fAuth.currentUser?.uid);
    return 0;
  }

  Future<String> _getCartProduct(product_id) async {
    String errorMessage = "";
    try {
      DocumentSnapshot<Map<String, dynamic>> getter = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(_fAuth.currentUser?.uid)
          .collection("cart")
          .doc(product_id)
          .get();
      currentProduct = getter.data()!;
    } catch (error) {
      errorMessage = "ERRORRR";
    }
    if (errorMessage != "") {
      return errorMessage;
    }
    return "Success";
  }

  Future<int> configureCart(product_id, action) async {
    HomeCartState.inProgress = true;
    int x = -1000;
    var docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("cart")
        .doc(product_id);
    String res = await _getCartProduct(product_id);
    if (res == "Success") {
      x = currentProduct["amount"]!;
    }
    docRef.get().then((doc) async => {
          if (doc.exists && res == "Success" && action == "-" && x == 1)
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("cart")
                  .doc(product_id)
                  .delete()
            }
          else if (doc.exists &&
              action == "+" &&
              res == "Success" &&
              x != -1000)
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("cart")
                  .doc(product_id)
                  .update({"product_id": product_id, "amount": ++x})
            }
          else if (doc.exists &&
              action == "-" &&
              res == "Success" &&
              x != -1000 &&
              x != 1)
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("cart")
                  .doc(product_id)
                  .set({"product_id": product_id, "amount": --x})
            }
          else
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_fAuth.currentUser?.uid)
                  .collection("cart")
                  .doc(product_id)
                  .set({"product_id": product_id, "amount": 1})
            }
        });
    ProductsData pd = ProductsData();
    await pd.parseCartProducts(_fAuth.currentUser?.uid);
    return 0;
  }

  Future<List<Product>> _getDataBakery() async {
    var records = await FirebaseFirestore.instance
        .collection("products")
        .doc("bakery")
        .collection("menu")
        .get();
    //_referenceCakes.snapshots();
    return bakeryData = _mapRecords(records);
  }

  Future<List<Product>> _getDataDesserts() async {
    var records = await FirebaseFirestore.instance
        .collection("products")
        .doc("desserts")
        .collection("menu")
        .get();
    return dessertsData = _mapRecords(records);
  }

  Future<List<Product>> _getDataCakes() async {
    var records = await FirebaseFirestore.instance
        .collection("products")
        .doc("cakes")
        .collection("menu")
        .get();
    return cakesData = _mapRecords(records);
  }

  Future<List<Product>> _getDataCoffee() async {
    var records = await FirebaseFirestore.instance
        .collection("products")
        .doc("coffee")
        .collection("menu")
        .get();
    return coffeeData = _mapRecords(records);
  }

  Future<List<FavoriteProduct>> _getFavorites(user_id) async {
    var records = await FirebaseFirestore.instance
        .collection("users")
        .doc(user_id)
        .collection("favorites")
        .get();
    return favoriteData = _mapFavorites(records);
  }

  Future<List<CartProduct>> getCart(user_id) async {
    var records = await FirebaseFirestore.instance
        .collection("users")
        .doc(user_id)
        .collection("cart")
        .get();
    return cartData = _mapCart(records);
  }

  Future<List<Product>> _getDataSet() async {
    return dataset = bakeryData + dessertsData + coffeeData + cakesData;
  }

  _mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) => Product(
            id: item.id,
            name: item["name"],
            price: item["price"],
            description: item["description"]))
        .toList();
    return list;
  }

  _mapFavorites(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) => FavoriteProduct(
              product_id: item["product_id"],
            ))
        .toList();
    return list;
  }

  _mapCart(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) => CartProduct(
              product_id: item["product_id"],
              amount: item["amount"],
            ))
        .toList();
    return list;
  }
}
