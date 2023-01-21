import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/default_button.dart';

import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/forget_password/forget_password_screen.dart';
import 'package:najikkopasal/screens/home/components/nav.dart';
import 'package:najikkopasal/widget/error_snakbar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/custom_suffix-icon.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              channelKey: 'basic_channel',
              title: 'Login',
              body: "Login Succesfully",
              id: 1));
      Navigator.pushNamed(context, Navbar.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: 1),
        content: ErrorSnakbar(
          message: "Either Email or Password is incorrect",
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      )); // MotionToast.error

    }
  }

  _login() async {
    try {
      UserRepository userRepository = UserRepository();

      bool isLogin = await userRepository.login(
        _emailController.text,
        _passwordController.text,
      );

      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {}
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

  @override
  void initState() {
    super.initState();
    // autoLogin();
  }

  // void autoLogin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString('token');

  //   // convert userdate to string dynamic

  //   print("Token aaayena ta ke vo");
  //   print(token);
  //   if (token!.isNotEmpty) {
  //     _navigateToScreen(true);
  //   } else {
  //     _navigateToScreen(false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            children: [
              Checkbox(
                  activeColor: kPrimaryColor,
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgetPasswordScreen.routeName),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(26),
          ),
          DefaultButton(
            text: "Login",
            key: const Key("Login"),
            press: () {
              if (_formKey.currentState!.validate()) {
                _login();
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      key: const ValueKey("password"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
      },
      decoration: const InputDecoration(
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelText: "Password",
        hintText: "Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      key: const ValueKey("email"),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email is required";
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
