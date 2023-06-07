import 'package:flutter/material.dart';


class MyOrdersPage extends StatefulWidget {
  final List<Map<String, dynamic>> ordersData;
  const MyOrdersPage({super.key, required this.ordersData});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
