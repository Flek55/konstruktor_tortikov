import 'package:flutter/material.dart';
import 'package:tortik/pages/Home/home_menu.dart';
import 'package:tortik/pages/Home/home_profile.dart';
import 'package:tortik/pages/Home/home_cart.dart';
import 'package:tortik/pages/Home/home_liked.dart';


class HomeInteraction extends StatefulWidget {
  const HomeInteraction({Key? key}) : super(key: key);

  @override
  State<HomeInteraction> createState() => _HomeInteractionState();
}

class _HomeInteractionState extends State<HomeInteraction> {
  int _selectedTab = 0;

  _changeTab(int index){
    setState(() {
      _selectedTab = index;
    });
  }
  static const List<Widget> _widgets = <Widget>[
    HomeMenu(),
    HomeLiked(),
    HomeCart(),
    HomeProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _widgets.elementAt(_selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: const Color(0xFF5B2C6F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')]));
  }
}