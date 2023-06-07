import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/db_data.dart';
import 'Home/home_interaction.dart';
import 'Home/product_page.dart';

class OrderPage extends StatefulWidget {
  final Function() notifyParent;
  final List<Map<String, dynamic>> input;

  const OrderPage({super.key, required this.notifyParent, required this.input});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Map<String, dynamic>> pageData = [];

  @override
  void initState() {
    pageData = widget.input;
    widget.notifyParent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              Text(
                "Заказ создан!",
                style: GoogleFonts.akayaKanadaka(),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _getListView(),
            ],
          ),
        )));
  }

  _getListView() {
    if (widget.input.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: pageData.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: ListTile(
              onTap: () {
                ProductsData.selectedProductId = pageData[index]["id"];
                HomeInteractionState.selectedTab = 2;
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ProductPage(notifyParent: (){setState(() {

                            });})));
              },
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(
                "${pageData[index]["name"]}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 16.5),
              ),
              subtitle: Text(
                  "${pageData[index]["description"]}\n₽${pageData[index]["price"]}"),
          ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(top: 10));
        },
      );
    } else {
      return Column(children: [
        Container(
          height: 100,
          width: 300,
          child: const Text("Корзина пуста"),
        ),
      ]);
    }
  }
}
