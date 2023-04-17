import 'package:flutter/material.dart';

class HomeLiked extends StatefulWidget {
  const HomeLiked({Key? key}) : super(key: key);

  @override
  State<HomeLiked> createState() => _HomeLikedState();
}

class _HomeLikedState extends State<HomeLiked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: const [],
          ),
          Row(children: const [
            Padding(padding: EdgeInsets.only(top: 50, left: 40)),
            Text('Ваши любимые десерты \nвсегда с вами!',
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: 'Roboto',
                fontSize: 25,
                color: Colors.black,
              ),)]
          ),
        ],
      ),
    );
  }
}