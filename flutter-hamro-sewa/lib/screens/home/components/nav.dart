import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/cart/cart_screen.dart';
import 'package:najikkopasal/screens/cart/product_list.dart';
import 'package:najikkopasal/screens/home/home_screen.dart';

import 'package:najikkopasal/screens/profile/profile.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);
  static String routeName = '/navbar';

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  var _page = 0;
  final pages = [
    HomePage(),
    // ProductListScreen(),
    Container(color: Colors.white),
    const CartScreen(),

    Container(color: Colors.white),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Color.fromARGB(255, 247, 247, 247),
        backgroundColor: Colors.white,
        buttonBackgroundColor: kPrimaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
          ),
          Icon(Icons.settings),
          Icon(Icons.shopping_cart),
          Icon(Icons.add),
          Icon(Icons.person),
        ],
      ),
      body: pages[_page],
    );
  }
}
