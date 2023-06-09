import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/Services/db_data.dart';

import '../../Services/server_data.dart';
import 'home_liked.dart';


class ProductPage extends StatefulWidget {
  final Function() notifyParent;
  final String imageURL;
  const ProductPage({Key? key, required this.notifyParent, required this.imageURL}) : super(key: key);

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
        iconTheme: const IconThemeData(color:Colors.white),
        title: Text(pageData.name,style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20)),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(onPressed: () async {
            HomeLikedState.likedData.clear();
            HomeLikedState.ans.clear();
            DataGetter dg = DataGetter();
            await dg.configureLikedProduct(pageData.id);
            ProductsData pd = ProductsData();
            await pd.parseLikedProducts(FirebaseAuth.instance.currentUser?.uid);
            HomeLikedState.likedData = HomeLikedState.compressLiked();
            await widget.notifyParent();
          },
          icon: const Icon(Icons.favorite,color: Colors.white,),
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          SizedBox(child: Image.network(widget.imageURL, scale: 6,)),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left: 30)),
            Text("\nОписание: ",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16)),
            Text("\n\n${pageData.description}\n",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16))]),
          Row(children:[const Padding(padding: EdgeInsets.only(left: 30,top: 20)),
            Text("Цена:\t",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16)),
            Text("₽${pageData.price}",style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16))])]));
  }
}
