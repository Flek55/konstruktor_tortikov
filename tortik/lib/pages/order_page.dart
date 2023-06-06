import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          Text("Заказ создан!", style: GoogleFonts.akayaKanadaka(),)
        ],
      ),
    );
  }
}
