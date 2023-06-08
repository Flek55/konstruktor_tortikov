import 'package:flutter/material.dart';
import 'package:tortik/pages/order_products_page.dart';


class MyOrdersPage extends StatefulWidget {
  final List<List<Map<String, dynamic>>> ordersData;
  final List<String> orderIds;
  const MyOrdersPage({super.key, required this.ordersData, required this.orderIds});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color:Colors.white),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Мои заказы",style: Theme.of(context).textTheme.displaySmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              _getListView(),
            ],
          ),
        ),
      ),
    );
  }

  _getListView() {
    if (widget.orderIds.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: widget.orderIds.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>  OrderProductsPage(data: widget.ordersData[index],),
                      ));
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.black12),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text("Заказ №${widget.orderIds[index]}",style:Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 16.5)),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(top: 10));
        },
      );
    } else {
      return SizedBox(
        height: 100,
        width: 300,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(left:40)),
            Text("\tВы пока что не сделали\n\tни одного заказа=(",style: Theme.of(context).textTheme.displayMedium,)
          ],
        )
      );
    }
  }
}
