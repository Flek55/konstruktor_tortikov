import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/favorite_product.dart';
import 'package:tortik/Services/server_data.dart';

class ProductsData {
  static List<Product> dataset = [];
  static String selectedProductId = "";
  static List<Product> bakeryData = [];
  static List<Product> dessertsData = [];
  static List<Product> cakesData = [];
  static List<Product> coffeeData = [];
  static List<FavoriteProduct> favoriteDataPD = [];

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
}

class DataGetter {
  List<Product> dataset = [];
  List<Product> bakeryData = [];
  List<Product> dessertsData = [];
  List<Product> cakesData = [];
  List<Product> coffeeData = [];
  List<FavoriteProduct> favoriteData = [];
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<int> configureLikedProduct(product_id) async {
    var docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(_fAuth.currentUser?.uid)
        .collection("favorites")
        .doc(product_id);
    docRef.get().then((doc) async => {
    if (doc.exists){
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

  Future<List<Product>> _getDataSet() async {
    return dataset = bakeryData + dessertsData + coffeeData + cakesData;
  }

  _mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) =>
        Product(
            id: item.id,
            name: item["name"],
            price: item["price"],
            description: item["description"]))
        .toList();
    return list;
  }

  _mapFavorites(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) =>
        FavoriteProduct(
          product_id: item["product_id"],
        ))
        .toList();
    return list;
  }
}
