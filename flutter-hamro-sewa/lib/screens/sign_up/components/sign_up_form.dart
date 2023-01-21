import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/constants.dart';

import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/sign_in/sign_in_screen.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:najikkopasal/widget/error_snakbar.dart';
import 'package:najikkopasal/widget/successbar.dart';

import '../../../components/custom_suffix-icon.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  _registerUser(User user) async {
    bool isLogin = await UserRepository().registerUser(user);
    if (isLogin) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              channelKey: 'basic_channel',
              title: 'Register',
              body: "Register Succesfully",
              id: 1));

      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(msg) {
    if (msg) {
      Navigator.pushNamed(context, SignInScreen.routeName);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Successbar(
          message: "User registered successfully",
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: ErrorSnakbar(),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ));
    }
  }

  String? fullname;
  String? email;
  String? password;
  // String? confirmpassword;

  final List<String> errors = [];

  final _formKey = GlobalKey<FormState>();
  File? imgs;
  String? base63;

  // Future _loadImages(ImageSource imageSourc) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: imageSourc);
  //     final bytes = File(image!.path).readAsBytesSync();
  //     String base64Image = "data:image/png;base64," + base64Encode(bytes);

  //     if (base64Image != null) {
  //       setState(() {
  //         imgs = File(image.path);
  //         base63 = base64Image;
  //       });
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to pick Image $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Widget bottomSheet() {
    //   return Container(
    //     height: 100.0,
    //     width: MediaQuery.of(context).size.width,
    //     margin: const EdgeInsets.symmetric(
    //       horizontal: 20,
    //       vertical: 20,
    //     ),
    //     child: Column(
    //       children: <Widget>[
    //         const Text(
    //           "Choose Register Account photo",
    //           style: TextStyle(
    //             fontSize: 20.0,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    //           TextButton.icon(
    //             icon: Icon(Icons.camera),
    //             label: const Text("Camera"),
    //             onPressed: () {
    //               _loadImages(ImageSource.camera);
    //             },
    //           ),
    //           TextButton.icon(
    //             icon: const Icon(Icons.image),
    //             onPressed: () {
    //               _loadImages(ImageSource.gallery);
    //             },
    //             label: const Text("Gallery"),
    //           ),
    //         ])
    //       ],
    //     ),
    //   );
    // }

    // Widget imageProfile() {
    //   return Stack(children: [
    //     CircleAvatar(
    //       radius: 50,
    //       child: ClipOval(
    //         child: SizedBox(
    //           width: 100.0,
    //           height: 100.0,
    //           child: (imgs != null)
    //               ? Image.file(
    //                   imgs!,
    //                   fit: BoxFit.fill,
    //                 )
    //               : Image.asset(
    //                   "assets/images/profile.jpg",
    //                   fit: BoxFit.fill,
    //                 ),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       bottom: 20.0,
    //       right: 10.0,
    //       child: InkWell(
    //         onTap: () {
    //           // showModalBottomSheet(
    //           //   context: context,
    //           //   builder: ((builder) => bottomSheet()),
    //           // );
    //         },
    //         child: const Icon(
    //           Icons.camera_alt,
    //           size: 25.0,
    //           color: Color.fromARGB(255, 215, 22, 22),
    //         ),
    //       ),
    //     ),
    //   ]);
    // }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // imageProfile(),

          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          buildNameFormFild(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildConfirmPasswordFormFiled(),

          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Sign Up",
              key: const Key("SignUp"),
              press: () {
                if (_formKey.currentState!.validate()) {
                  User user = User(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  _registerUser(user);
                }
              })
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      key: const ValueKey("password"),
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        } else if (value.length <= 8) {
          return "Password must be at least 8 characters";
        }
        return null;
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
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        } else if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return "Please enter a valid email";
        }
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildNameFormFild() {
    return TextFormField(
      controller: _nameController,
      key: const ValueKey("name"),
      onSaved: (newValue) => fullname = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Name";
        } else if (value.length <= 5) {
          return "Name should be at least 5 characters long";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
