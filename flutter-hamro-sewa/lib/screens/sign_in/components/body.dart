import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/sign_in/components/sign_in_form.dart';

import 'package:najikkopasal/size_config.dart';

import '../../../components/not_account_yet_text.dart';
import '../../../components/social_card_icon.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(18)),
          // Solve overflow by SingleChildScrollView
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Sign in with your email and password  \nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              const SignInForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconCard(
                    icon: "assets/icons/facebook-2.svg",
                    press: () {},
                  ),
                  SocialIconCard(
                    icon: "assets/icons/google-icon.svg",
                    press: () {},
                  ),
                  SocialIconCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const NotAccountYetText(),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
