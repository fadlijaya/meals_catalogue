import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealscatalogue/constant.dart';
import 'package:mealscatalogue/view/dessert_page.dart';
import 'package:mealscatalogue/view/favorite_page.dart';
import 'package:mealscatalogue/view/seafood_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Categories());
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List<Widget> listPage = [
    SeafoodPage(
      foodCategory: kSeafood,
    ),
    DessertPage(
      foodCategory: kDessert,
    ),
    FavoritePage()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: listPage.elementAt(selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 48,
        items: <Widget>[
          Icon(
            Icons.cake,
            size: 24,
            color: kWhite,
          ),
          Icon(
            Icons.fastfood,
            size: 24,
            color: kWhite,
          ),
          Icon(
            Icons.favorite,
            size: 24,
            color: kWhite,
          )
        ],
        color: kBlack,
        buttonBackgroundColor: kBlack,
        backgroundColor: kWhite,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
