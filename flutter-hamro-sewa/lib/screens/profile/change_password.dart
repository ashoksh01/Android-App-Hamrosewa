import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/custom_suffix-icon.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/components/form_error.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/home/components/nav.dart';
import 'package:najikkopasal/screens/profile/profile.dart';
import 'package:najikkopasal/widget/error_snakbar.dart';
import 'package:najikkopasal/widget/successbar.dart';

class ChangePassword extends StatefulWidget {
  static String routeName = '/change_password';
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  String? new_password;
  String? password;
  String? confirmpassword;

  final _passwordOldController = TextEditingController();
  final _passwordNewController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  _navigateToScreen(bool isUpdated) {
    if (isUpdated) {
      Navigator.pushNamed(context, Navbar.routeName);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.transparent,
        content: Successbar(
          message: "Password updated successfully",
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ));
      // MotionToast.success
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: ErrorSnakbar(
          message: "Password not updated",
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      )); // M // MotionToast.error
    }
  }

  _chnagePassword() async {
    try {
      UserRepository userRepository = UserRepository();

      bool isUpdated = await userRepository.userchangePassword(
        _passwordOldController.text,
        _passwordNewController.text,
        _passwordConfirmController.text,
      );

      if (isUpdated) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: ErrorSnakbar(
          message: "$e.toString()",
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      )); // MotionToast.error

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 208, 39, 39)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              buildPasswordFormField(),
              SizedBox(height: 20),
              buildNewPasswordFormField(),
              SizedBox(height: 20),
              buildConfirmPasswordFormFiled(),
              SizedBox(height: 20),
              FormError(erros: errors),
              DefaultButton(
                  text: "Chnage password",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _chnagePassword();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordOldController,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your old password";
        }
        return null;
      },
      decoration: const InputDecoration(
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelText: "Old Password",
        hintText: "Enter Your old Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNewPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordNewController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter new password";
        } else if (value.length <= 8) {
          return "Password must be at least 8 characters";
        }
      },
      decoration: const InputDecoration(
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelText: "New Password",
        hintText: "Enter Your New Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildConfirmPasswordFormFiled() {
    return TextFormField(
      obscureText: true,
      controller: _passwordConfirmController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter confirm password";
        } else if (value != _passwordNewController.text) {
          return "Password does not match";
        }
      },
      decoration: const InputDecoration(
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelText: " Confirm Password",
        hintText: "Re-Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
