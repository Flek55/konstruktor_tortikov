import 'package:flutter/material.dart';
import 'package:tortik/pages/Home/home_menu.dart';

import '../../Services/server_data.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final int productIndex = HomeMenuState.selectedIndex;
  final Product pageData = HomeMenuState.currentData[HomeMenuState.selectedIndex];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(pageData.name),
        backgroundColor: const Color(0xFF5B2C6F),
        actions: [
          IconButton(onPressed: () {

          },
          icon: const Icon(Icons.favorite),
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left: 40)),
            Text(pageData.description)]),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left: 40)),
            Text("₽${pageData.price}")]),
        ],
      ),
    );
  }
}
