import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/Services/db_data.dart';

import '../../Services/server_data.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final String productIndex = ProductsData.selectedProductId;
  late final Product pageData;

  Product? findIndex(index){
    for (int i = 0; i < ProductsData.dataset.length; i++){
      if (ProductsData.dataset[i].id.toString() == index){
        return ProductsData.dataset[i];
      }
    }
    return null;
  }
  @override
  void initState() {
    pageData = findIndex(productIndex)!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Material(
            color: Colors.transparent,
          child:InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,),
          )
        ),
        title: Text(pageData.name),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(onPressed: () async {
            DataGetter dg = DataGetter();
            await dg.configureLikedProduct(pageData.id);
            ProductsData pd = ProductsData();
            await pd.parseLikedProducts(FirebaseAuth.instance.currentUser?.uid);
          },
          icon: const Icon(Icons.favorite,color: Colors.white),
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left: 40)),
            Text(pageData.description),]),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left: 40)),
            Text("₽${pageData.price}",)]),
        ],
      ),
    );
  }
}
