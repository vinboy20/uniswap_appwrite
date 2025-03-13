import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/core/app_export.dart'; // Your app's export file
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';

class UserHeaderProfile extends StatefulWidget {
  const UserHeaderProfile({super.key});

  @override
  State<UserHeaderProfile> createState() => _UserHeaderProfileState();
}

class _UserHeaderProfileState extends State<UserHeaderProfile> {
  @override
  Widget build(BuildContext context) {
    final userData = SavedData.getUserData();
    // Access individual fields from the user data
    final photo = userData['photo'] ?? '';
    String username = userData['name'] ?? '';
    final avatar = userData['avatar'] ?? '';
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.only(right: 9.w),
        child: Row(
          children: [
            // Profile Image
            photo.toString().isNotEmpty
                ? FilePreviewImage(
                    bucketId: Credentials.userBucketId,
                    fileId: photo.toString(),
                    width: 72.h,
                    height: 72.h,
                    isCircular: true,
                  ):
                 CustomImageView(
                    imagePath: avatar, // Default profile image
                    height: 72.h,
                    width: 72.h,
                    radius: BorderRadius.circular(50.w),
                  ),
            // User Details
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 15.h, bottom: 13.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Good day", style: CustomTextStyles.text16w400),
                  SizedBox(height: 2.h),
                  Text(
                    username, // User's name
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
