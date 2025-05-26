import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/appbar/chat_float_button.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/home/screens/profile/widget/profile_nav.dart';
import 'package:uniswap/features/personalization/screen/my_uploads_screen/my_uploads_screen.dart';
import 'package:uniswap/features/personalization/screen/profile_screen/profile_form_update_screen/profile_form_update_screen.dart';
import 'package:uniswap/features/personalization/screen/ratings_screen/ratings_screen.dart';
import 'package:uniswap/features/personalization/screen/settings_screen/settings_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final userData = SavedData.getUserData();
    // Access individual fields from the user data
    final photo = userData['photo'] ?? '';
    String username = userData['name'] ?? '';
    final avatar = userData['avatar'] ?? '';
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
         floatingActionButton: chatFloatButton(context),
        appBar: TAppBar(
          title: Text(
            "My Profile",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                photo.toString().isNotEmpty
                ? FilePreviewImage(
                    bucketId: Credentials.userBucketId,
                    fileId: photo.toString(),
                    width: 72.w,
                    height: 72.h,
                    isCircular: true,
                  ):
                 CustomImageView(
                    imagePath: avatar, // Default profile image
                    height: 72.h,
                    width: 72.w,
                    radius: BorderRadius.circular(50.w),
                  ),
                SizedBox(height: 13.h),
                Text(username, style: CustomTextStyles.text14w400),
                SizedBox(height: 12.h),
                const Divider(
                  indent: 80,
                  endIndent: 80,
                  thickness: 0.5,
                  color: TColors.primary,
                ),
                SizedBox(height: 32.h),
                profileNav(
                  context,
                  icon: Icons.person_rounded,
                  title: "Personal details",
                  onTap: () {
                    Get.to(() => const ProfileFormUpdateScreen());
                  },
                ),
                profileNav(
                  context,
                  icon: Icons.file_upload_rounded,
                  title: "My uploads",
                  onTap: () {
                    Get.to(() => const MyUploadsScreen());
                  },
                ),
                profileNav(
                  context,
                  icon: Icons.star_rounded,
                  title: "Reviews and ratings",
                  onTap: () {
                    Get.to(() => const RatingsScreen());
                  },
                ),
                profileNav(
                  context,
                  icon: Icons.notifications,
                  title: "Notifications",
                  onTap: () {
                    // Get.to(() => const NotificationScreen());
                  },
                ),

                profileNav(
                  context,
                  icon: Icons.settings_rounded,
                  title: "Settings",
                  onTap: () {
                    Get.to(() => const SettingsScreen());
                  },
                ),
                profileNav(
                  context,
                  icon: Icons.person_add_alt_1,
                  title: "Invite friend",
                  onTap: () {
                    onTapInvite(context);
                  },
                ),
                // _buildInviteContainer(context),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapNotifications(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.ratingsScreen);
    // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.notificationThreeScreen);
  }

  onTapSetting(BuildContext context) {
    // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.settingsScreen);
  }

  onTapInvite(BuildContext context) {
    // showDialog(context: context, builder: (BuildContext context) => PopupPlaceholderTwoScreen());
  }
}
