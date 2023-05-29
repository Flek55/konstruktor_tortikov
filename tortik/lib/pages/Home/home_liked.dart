import 'package:flutter/material.dart';
import 'package:tortik/Services/db_data.dart';

import '../../Services/server_data.dart';

class HomeLiked extends StatefulWidget {
  const HomeLiked({Key? key}) : super(key: key);

  @override
  State<HomeLiked> createState() => _HomeLikedState();
}

class _HomeLikedState extends State<HomeLiked> {
  static List<Product> likedData = [];

  @override
  void initState() {
    likedData = ProductsData.favoriteData;
    super.initState();
  }

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
            Text(
              'Ваши любимые десерты \nвсегда с вами!',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 25,
                color: Colors.black,
              ),
            )
          ]),
          _getListView(),
        ],
      ),
    );
  }

  _getListView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: likedData.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(likedData[index].name),
              subtitle: Text(
                  "${likedData[index].description} ₽${likedData[index].price}"),
              trailing: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Icon(Icons.add),
                      ))),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(padding: EdgeInsets.only(top: 10));
      },
    );
  }
}
