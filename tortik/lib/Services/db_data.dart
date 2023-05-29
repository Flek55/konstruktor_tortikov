import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/server_data.dart';


class ProductsData{
  static List<Product> bakeryData = [];
  static List<Product> dessertsData = [];
  static List<Product> cakesData = [];
  static List<Product> coffeeData = [];
  static List<Product> favoriteData = [];

  Future<int> parseData() async{
    final DataGetter dg = DataGetter();
    bakeryData = await dg._getDataBakery();
    dessertsData = await dg._getDataDesserts();
    cakesData = await dg._getDataCakes();
    coffeeData = await dg._getDataCoffee();
    return 0;
  }

  Future<int> parseLikedProducts(user_id) async{
    final DataGetter dg = DataGetter();
    favoriteData = await dg._getFavorites(user_id);
    return 0;
  }
}


class DataGetter{
  List<Product> bakeryData = [];
  List<Product> dessertsData = [];
  List<Product> cakesData = [];
  List<Product> coffeeData = [];
  List<Product> favoriteData = [];
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<int> addLikedProduct(product_id) async{
    if (favoriteData.length == 1) {
      await FirebaseFirestore.instance.collection("users").
      doc(_fAuth.currentUser?.uid).collection("favorites").
      doc(product_id).update({"product_id": product_id}).
      then((value) => null, onError: (e) =>
          FirebaseFirestore.instance.collection("favorites").
          doc(product_id).set({"product_id": product_id}));
      await FirebaseFirestore.instance.collection("users").
      doc(_fAuth.currentUser?.uid).collection("favorites").
      doc("delete").delete().onError((error, stackTrace) => null);
      return 0;
    }else{
      await FirebaseFirestore.instance.collection("users").
      doc(_fAuth.currentUser?.uid).collection("favorites").
      doc(product_id).update({"product_id": product_id}).
      then((value) => null, onError: (e) =>
          FirebaseFirestore.instance.collection("favorites").
          doc(product_id).set({"product_id": product_id}));
      return 0;
    }
  }

  Future<int> removeLikedProduct(product_id) async{
    await FirebaseFirestore.instance.collection("users").
    doc(_fAuth.currentUser?.uid).collection("favorites").
    doc(product_id).delete();
    return 0;
  }

  Future<List<Product>> _getDataBakery() async{
    var records = await FirebaseFirestore.instance.collection("products").doc("bakery").collection("menu").get();
    //_referenceCakes.snapshots();
    return bakeryData = _mapRecords(records);
  }

  Future<List<Product>> _getDataDesserts() async{
    var records = await FirebaseFirestore.instance.collection("products").doc("desserts").collection("menu").get();
    return dessertsData = _mapRecords(records);
  }

  Future<List<Product>> _getDataCakes() async{
    var records = await FirebaseFirestore.instance.collection("products").doc("cakes").collection("menu").get();
    return cakesData = _mapRecords(records);
  }

  Future<List<Product>> _getDataCoffee() async{
    var records = await FirebaseFirestore.instance.collection("products").doc("coffee").collection("menu").get();
    return coffeeData = _mapRecords(records);
  }

  Future<List<Product>> _getFavorites(user_id) async{
    var records = await FirebaseFirestore.instance.collection("users").doc(user_id).collection("favorites").get();
    return favoriteData = _mapRecords(records);
  }

  _mapRecords(QuerySnapshot<Map<String, dynamic>> records){
    var list = records.docs.map(
            (item) => Product(
            id: item.id,
            name: item["name"],
            price: item["price"],
            description: item["description"])
    ).toList();
    return list;
  }
}