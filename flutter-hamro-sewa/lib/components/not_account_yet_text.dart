import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/sign_up/sign_up_screen.dart';

import '../screens/forget_password/forget_password_screen.dart';
import '../size_config.dart';

class NotAccountYetText extends StatelessWidget {
  const NotAccountYetText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: getProportionateScreenWidth(18)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
