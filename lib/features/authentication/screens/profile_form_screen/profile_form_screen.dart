import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/features/authentication/screens/profile_form_screen/widget/profile_form_reg.dart';
import 'package:uniswap/features/authentication/screens/profile_form_screen/widget/progress_bar.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({super.key});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: TAppBar(
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          showBackArrow: true,
          title: Text(
            "Personal Details",
            style: CustomTextStyles.text16w400,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 25.h, left: 24, right: 24),
          child: Column(
            children: [
              ProgressBar(),
              ProfileFormReg(),
            ],
          ),
        ),
      ),
    );
  }

}

