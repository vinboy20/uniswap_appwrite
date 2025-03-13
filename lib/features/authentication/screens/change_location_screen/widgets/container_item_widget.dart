import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';


class ContainerItemWidget extends StatelessWidget {
  const ContainerItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      autofocus: false,
      //controller: passwordController,
      textInputAction: TextInputAction.done,
      hintText: "Ibeju Lekki, Lagos",
      prefix: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
        child: const Icon(Icons.add_location_outlined),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 56.h),
      obscureText: true,
      borderDecoration: OutlineInputBorder(borderSide: BorderSide(width: 0.5.w, color: Colors.transparent), borderRadius: BorderRadius.circular(50.w)),
      //borderDecoration: TextFormFieldStyleHelper.outlineOnError,
      filled: true,
      fillColor: TColors.gray50,
    );
  }
}
