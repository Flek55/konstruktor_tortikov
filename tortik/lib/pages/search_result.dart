import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/db_data.dart';
import 'Home/product_page.dart';

class SearchResultPage extends StatefulWidget {
  final List data;

  const SearchResultPage({super.key, required this.data});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.onPrimary,iconTheme:const IconThemeData(color:Colors.white),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              _getListView(),

            ],
          ),
        ),
      ),
    );
  }

  _getProductPush(url){
    return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              ProductPage(notifyParent: (){}, imageURL: url,),
        ));
  }

  _getListView() {
    if (widget.data.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: widget.data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: ListTile(
                onTap: () async {
                  ProductsData.selectedProductId = widget.data[index].id;
                  DataGetter dg = DataGetter();
                  String url = await dg.getProductImageURL(ProductsData.selectedProductId);
                  _getProductPush(url);
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(widget.data[index].name, style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 16.5)),
                subtitle: Text(
                    "${widget.data[index].description}\n₽${widget.data[index]
                        .price}"),
                trailing: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () async {
                          DataGetter dg = DataGetter();
                          await dg.configureCart(widget.data[index].id, "+");
                          ProductsData pd = ProductsData();
                          await pd.parseCartProducts(
                              FirebaseAuth.instance.currentUser?.uid);
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
        child: Row(children: [Padding(padding: EdgeInsets.only(left:20)),Text("Нет Результата!"),],)
      );
    }
  }
}
