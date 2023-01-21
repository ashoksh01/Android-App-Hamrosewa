import 'package:flutter/material.dart';

import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/sign_up/components/sign_up_form.dart';
import 'package:najikkopasal/size_config.dart';

import '../../../components/social_card_icon.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Register Account",
              style: headingStyle,
            ),
            const Text(
              "Complete your details or continue\n with social media",
              textAlign: TextAlign.center,
            ),

            // SizedBox(
            //   child: CircleAvatar(
            //     backgroundColor: Colors.greenAccent[400],
            //     radius: 40,
            //     child: const Text(
            //       'GeeksForGeeks',
            //       style: TextStyle(fontSize: 25, color: Colors.white),
            //     ), //Text
            //   ), //,
            // ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            const SignUpForm(),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
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
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            const Text(
              "You Can also Sign Up through Above Medium ",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
          ]),
        ),
      ),
    );
  }
}
