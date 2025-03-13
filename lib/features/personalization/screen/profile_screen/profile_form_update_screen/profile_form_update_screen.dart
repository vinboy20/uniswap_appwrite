import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/profile_form_update_screen/widget/profile_update.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/profile_form_update_screen/widget/progress_bar_update.dart';

class ProfileFormUpdateScreen extends StatelessWidget {
  const ProfileFormUpdateScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              ProgressBarUpdate(),
              ProfileUpdate(),
            ],
          ),
        ),
      ),
    );
  }

}

