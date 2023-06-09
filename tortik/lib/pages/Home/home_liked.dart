import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tortik/Services/db_data.dart';
import 'package:tortik/pages/Home/home_interaction.dart';
import 'package:tortik/pages/Home/product_page.dart';

import '../../Services/server_data.dart';

class HomeLiked extends StatefulWidget {
  const HomeLiked({Key? key}) : super(key: key);

  @override
  State<HomeLiked> createState() => HomeLikedState();
}

class HomeLikedState extends State<HomeLiked> {
  static List<Product> likedData = [];
  static List<Product> ans = [];

  @override
  void initState() {
    likedData = compressLiked();
    super.initState();
  }

  refresh(){
    setState(() {

    });
  }

  static List<Product> compressLiked() {
    List<String> ids = [];
    likedData.clear();
    for (int i = 0; i < ProductsData.favoriteDataPD.length; i++) {
      ids.add(ProductsData.favoriteDataPD[i].product_id.toString());
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 32)),
              Row(children: [
                const Padding(padding: EdgeInsets.only(top: 50, left: 40)),
                Text(
                  'Ваши любимые десерты \nвсегда с вами!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24)
                  ),
                const Padding(padding: EdgeInsets.only(top:92,left:40))
              ]),
              _getListView(),
            ],
          ),
        )));
  }

  _getProductPush(url){
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              ProductPage(notifyParent: refresh, imageURL: url,),
        ));
  }

  _getListView() {
    if (likedData.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: likedData.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: ListTile(
                onTap: () async {
                  ProductsData.selectedProductId = likedData[index].id;
                  HomeInteractionState.selectedTab = 1;
                  DataGetter dg = DataGetter();
                  String url = await dg.getProductImageURL(ProductsData.selectedProductId);
                  _getProductPush(url);
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(likedData[index].name,style:Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16.5)),
                subtitle: Text(
                    "${likedData[index].description}\n₽${likedData[index].price}"),
                trailing: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          DataGetter dg = DataGetter();
                          await dg.configureCart(likedData[index].id,"+");
                          ProductsData pd = ProductsData();
                          await pd.parseCartProducts(FirebaseAuth.instance.currentUser?.uid);
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
      return const SizedBox(
        height: 100,
        width: 300,
        child: Text("Нет избранного"),
      );
    }
  }
}
