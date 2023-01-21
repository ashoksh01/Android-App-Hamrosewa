import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najikkopasal/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.erros,
  }) : super(key: key);

  final List<String> erros;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
      erros.length,
      (index) => formErrorText(error: erros[index]),
    ));
  }

  Row formErrorText({String? error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: getProportionateScreenHeight(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(error!),
      ],
    );
  }
}
