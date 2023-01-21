import 'package:flutter/material.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/size_config.dart';

// import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  // static String routeName = "/login_success";

  const LoginSuccessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // remove tonavbar arrow
        leading: const SizedBox(),
        title: const Text("Login Success"),
        centerTitle: true,
      ),
    //   body:  Column(
    //   children: [
    //     SizedBox(height: SizeConfig.screenHeight * 0.04),
    //     Image.asset(
    //       "assets/images/success.png",
    //       height: SizeConfig.screenHeight * 0.4, //40%
    //     ),
    //     SizedBox(height: SizeConfig.screenHeight * 0.08),
    //     Text(
    //       "Login Success",
    //       style: TextStyle(
    //         fontSize: getProportionateScreenWidth(30),
    //         fontWeight: FontWeight.bold,
    //         color: Colors.black,
    //       ),
    //     ),
    //     const Spacer(),
    //     SizedBox(
    //       width: SizeConfig.screenWidth * 0.6,
    //       child: DefaultButton(
    //         text: "Back to home",
    //         press: () {
    //           // Navigator.pushNamed(context, HomeScreen.routeName);
    //         },
    //       ),
    //     ),
    //     const Spacer(),
    //   ],
    // ),
    );
  }
}
