import 'package:flutter/material.dart';
import 'package:najikkopasal/screens/splash/components/body.dart';
import 'package:najikkopasal/size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(

      body: Body(),
    );
  }
}
