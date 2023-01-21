import 'package:flutter/material.dart';
import 'package:najikkopasal/screens/home/components/body.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
