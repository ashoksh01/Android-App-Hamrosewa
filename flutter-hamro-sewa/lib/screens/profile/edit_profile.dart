import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/custom_suffix-icon.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/components/form_error.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/home/components/nav.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:najikkopasal/widget/successbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = '/edit_profile';

  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  String? image;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  File? img;
  String? base64;
  String? nbase64;
  String? name;
  String? email;

  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64," + base64Encode(bytes);

      if (base64Image != null) {
        setState(() {
          img = File(image.path);
          base64 = base64Image;
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  // Future preferences() async {
  //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // var data = sharedPreferences.getString('profile');

  //   // Map<String, dynamic> encodedData =
  //   //     jsonDecode(sharedPreferences.getString('profile')!);
  //   // User user = User.fromJson(encodedData);
  //   // setState(() {
  //   //   image = user.image;
  //   // });

  // }

  // @override
  // void initState() {
  //   super.initState();
  //   preferences();
  // }

  _updateUser() async {
    try {
      UserRepository userRepository = UserRepository();
      // if name is empty then send saved named

      bool isUpdate = await userRepository.updateprofile(
          _nameController.text, _emailController.text, base64.toString());
      if (isUpdate) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          content: Successbar(
            message: "Profile Updated Successfully",
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 3,
        ));
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // accept arguments from the previous screen
    final user = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      _nameController.text = user['name'];
      _emailController.text = user['email'];
      image = user['image'];
    });

    Widget bottomSheet() {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Choose Register Account photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
                onPressed: () {
                  _loadImage(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  _loadImage(ImageSource.gallery);
                },
                label: const Text("Gallery"),
              ),
            ])
          ],
        ),
      );
    }

    Widget imageProfile() {
      return Stack(children: [
        CircleAvatar(
          radius: 50,
          child: ClipOval(
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: (img != null)
                  ? Image.file(
                      img!,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      image.toString(),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 25.0,
              color: Color.fromARGB(255, 215, 22, 22),
            ),
          ),
        ),
      ]);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      imageProfile(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      buildNameFormFild(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      buildEmailFormField(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      FormError(erros: errors),
                      DefaultButton(
                        text: "Update Profile",
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _updateUser();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            _emailController.text = value;
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
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

  TextFormField buildNameFormFild() {
    return TextFormField(
      controller: _nameController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNameNullError)) {
          setState(() {
            _nameController.text = value;

            errors.remove(kNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kNameNullError)) {
          setState(() {
            errors.add(kNameNullError);
          });
          return "";
        }
        return null;
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
