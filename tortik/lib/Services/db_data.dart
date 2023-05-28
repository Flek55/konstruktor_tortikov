import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tortik/Services/server_data.dart';


class ProductsData{
  static List<Product> bakeryData = [];
  static List<Product> dessertsData = [];
  static List<Product> cakesData = [];
  static List<Product> coffeeData = [];

  Future<int> parseData() async{
    final DataGetter dg = DataGetter();
    bakeryData = await dg._getDataBakery();
    dessertsData = await dg._getDataDesserts();
    cakesData = await dg._getDataCakes();
    coffeeData = await dg._getDataCoffee();
    return 0;
  }
}


class DataGetter{
  List<Product> bakeryData = [];
  List<Product> dessertsData = [];
  List<Product> cakesData = [];
  List<Product> coffeeData = [];

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