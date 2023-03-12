import 'package:flutter/material.dart';


class BotNavCust extends StatefulWidget {
  const BotNavCust({Key? key}) : super(key: key);

  @override
  State<BotNavCust> createState() => _BotNavCustState();
}

class _BotNavCustState extends State<BotNavCust> {
  int _selectedTab = 0;

  static const List _pages = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text("Favourite"),
    ),
    Center(
      child: Text("Cart"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];
  _changeTab(int index){
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
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
              icon: Icon(Icons.favorite), label: 'Favorites'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              Text('Отличный кофе\nВсегда и везде!',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Roboto',
                fontSize: 25,
                color: Colors.black,
                ),)]
              ),
          ],
        ),
        bottomNavigationBar: const BotNavCust(),
        );
  }
}