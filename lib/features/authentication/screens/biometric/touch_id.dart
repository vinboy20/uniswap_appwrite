import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';


class TouchId extends StatelessWidget {
  const TouchId({super.key});

  @override
  Widget build(BuildContext context) {
  final AuthController controller = Get.put(AuthController());
    
    return GestureDetector(
      onTap: () async {
        await controller.authenticateUser();
      },
      child: Text(
        "Create touch ID",
        style: CustomTextStyles.text14w400cPrimary,
      ),
    );
  }
}
