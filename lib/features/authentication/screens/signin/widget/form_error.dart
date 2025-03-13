import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

   Row formErrorText({required String error}) {
    return Row(
      children: [
        // SvgPicture.asset(
        //   "assets/icons/Error.svg",
        //   height: getProportionateScreenWidth(14),
        //   width: getProportionateScreenWidth(14),
        // ),
        const SizedBox(
          width: 10,
        ),
        Text(error, style: const TextStyle(color: Colors.red),),
      ],
    );
  }
}


