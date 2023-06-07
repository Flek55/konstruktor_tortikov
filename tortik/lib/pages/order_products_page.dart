import 'package:flutter/material.dart';

import '../Services/db_data.dart';
import 'Home/product_page.dart';

class OrderProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const OrderProductsPage({super.key, required this.data});

  @override
  State<OrderProductsPage> createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          _getListView(),
        ])),
      ),
    );
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
                onTap: () {
                  ProductsData.selectedProductId =
                      widget.data[index]["product_id"];
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ProductPage(notifyParent: () {
                          setState(() {});
                        }),
                      ));
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(widget.data[index]["product_name"],
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 16.5)),
                trailing: SizedBox(
                  height: 23,
                  width: 16,
                  child: Text("${widget.data[index]["amount"]}"),
                ),
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
