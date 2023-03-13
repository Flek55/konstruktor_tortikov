import 'package:flutter/material.dart';

class HomeLiked extends StatefulWidget {
  const HomeLiked({Key? key}) : super(key: key);

  @override
  State<HomeLiked> createState() => _HomeLikedState();
}

class _HomeLikedState extends State<HomeLiked> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: Text("Избранное"),
      )
    );
  }
}
