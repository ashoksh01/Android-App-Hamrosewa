import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';

class ProfileWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Function()? onPressed;
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // give shape the conatiner to RoundedRectangleBorder

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          // color in button

          child: TextButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF5F6F9), // background
                onPrimary: kPrimaryColor,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 17, bottom: 15),
                        child: Icon(
                          icon,
                          color: kPrimaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        title!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
