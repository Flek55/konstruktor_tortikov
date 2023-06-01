import 'package:flutter/material.dart';
import 'package:tortik/pages/Home/home_menu.dart';
import 'package:tortik/pages/Home/home_profile.dart';
import 'package:tortik/pages/Home/home_cart.dart';
import 'package:tortik/pages/Home/home_liked.dart';


class HomeInteraction extends StatefulWidget {
  const HomeInteraction({Key? key}) : super(key: key);

  @override
  State<HomeInteraction> createState() => HomeInteractionState();
}

class HomeInteractionState extends State<HomeInteraction> {
  static int selectedTab = 0;

  changeTab(int index){
    setState(() {
      selectedTab = index;
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
    return Scaffold(body: _widgets.elementAt(selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: selectedTab,
        onTap: (index) => changeTab(index),
        selectedItemColor: Theme.of(context).primaryColorDark,
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