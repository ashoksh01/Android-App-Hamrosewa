import 'package:flutter/material.dart';
import 'package:najikkopasal/screens/forget_password/components/body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static String routeName = '/forget_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
