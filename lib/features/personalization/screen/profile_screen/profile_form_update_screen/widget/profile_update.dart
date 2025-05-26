import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/image_preview_widget.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/core/utils/helpers/network_manager.dart';
import 'package:uniswap/core/utils/validators/validation.dart';
import 'package:uniswap/data/saved_data.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final controller = Get.find<AuthController>();

  XFile? _pickedImage;
  bool profileLoading = false;

  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  final DatabaseController dataController = Get.find<DatabaseController>();

  late final String email;
  late String username;
  late String phone;
  late String bio;
  late String link;
  late String dob;
  late String gender;
  late final String avatar;
  late final String photo;

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;
  late TextEditingController linkController;
  late TextEditingController dobController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    // Retrieve the entire user data map
    final userData = SavedData.getUserData();
    // Access individual fields
    email = userData['email'] ?? "";
    username = userData['name'] ?? "";
    phone = userData['phone'] ?? "";
    bio = userData['bio'] ?? "";
    link = userData['link'] ?? "";
    dob = userData['dob'] ?? "";
    gender = userData['gender'] ?? "";
    avatar = userData['avatar'] ?? "";
    photo = userData['photo'] ?? "";

    fullNameController = TextEditingController(text: username);
    emailController = TextEditingController(text: email);
    phoneController = TextEditingController(text: phone);
    bioController = TextEditingController(text: bio);
    linkController = TextEditingController(text: link);
    dobController = TextEditingController(text: dob);
    genderController = TextEditingController(text: gender);
  }

  @override
  void dispose() {
    bioController;
    linkController;
    super.dispose();
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await THelperFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  Future<void> profileUpdate(XFile? image) async {
    try {
      // Start loading
      EasyLoading.show(status: 'We are processing your information...');
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EasyLoading.dismiss();
        return;
      }

      // Form validation
      if (!updateFormKey.currentState!.validate()) {
        EasyLoading.dismiss();
        return;
      }

      String fileId;
      if (image == null) {
        EasyLoading.dismiss();
        fileId = "";
      } else {
        // Upload the image and get the fileId
        final imageFileId =
            await dataController.uploadImage(Credentials.userBucketId, image);
        if (imageFileId == null) {
          throw Exception("Failed to upload image");
        } else {
          fileId = imageFileId;
        }
      }

      // Update user data in the database
      await dataController.updateUserDetails(
        {
          'phone': phoneController.text.trim(),
          'photo': fileId,
          'bio': bioController.text.trim(),
          'link': linkController.text.trim(),
        },
      );

      // update the userdata
      await dataController.getUserData();

      // Remove loader
      EasyLoading.dismiss();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your account has been created');
    } catch (e) {
      // Remove loader
      EasyLoading.dismiss();
      // Show error message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      // print('Error during saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: updateFormKey,
      child: Column(
        children: [
          // Image Picker
          SizedBox(
            height: 100.h,
            width: 98.w,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _pickedImage == null
                    ? photo.toString().isNotEmpty
                        ? FilePreviewImage(
                            bucketId: Credentials.userBucketId,
                            fileId: photo.toString(),
                            width: 72.w,
                            height: 72.h,
                            isCircular: true,
                          )
                        : CustomImageView(
                            imagePath: avatar,
                            height: 94.w,
                            width: 94.w,
                            radius: BorderRadius.circular(50.w),
                            alignment: Alignment.topLeft,
                          )
                    : ClipOval(
                        child: Image.file(
                          File(_pickedImage!.path),
                          height: 94.w,
                          width: 94.w,
                          fit: BoxFit
                              .cover, // Use cover to maintain aspect ratio while filling
                        ),
                      ),
                Positioned(
                  right: 0,
                  bottom: -10.h,
                  child: IconButton(
                    onPressed: () async {
                      await localImagePicker();
                    },
                    icon: Icon(
                      Icons.cloud_upload_rounded,
                      size: 24.sp,
                      color: TColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full Name", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                enabled: false,
                controller: fullNameController,
                hintText: "",
                hintStyle: CustomTextStyles.text12w400,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email address", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                enabled: false,
                controller: emailController,
                hintText: "email",
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.emailAddress,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone number", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: phoneController,
                hintText: "phone number",
                hintStyle: CustomTextStyles.text12w400,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.phone,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                validator: (value) => TValidator.validatePhoneNumber(value),
                fillColor: TColors.softGrey,
              ),
            ],
          ),

          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date of birth", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                enabled: false,
                controller: dobController,
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.emailAddress,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
                suffix: Icon(Icons.calendar_month),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomTextFormField(
            enabled: false,
            controller: genderController,
            hintStyle: CustomTextStyles.text12w400,
            textInputType: TextInputType.emailAddress,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
            borderDecoration: TextFormFieldStyleHelper.outlineOnError,
            filled: true,
            fillColor: TColors.softGrey,
          ),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bio (optional)", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: bioController,
                hintText: "Biography",
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.text,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add relevant link (optional)",
                  style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: linkController,
                hintText: "Link",
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.text,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          CustomPillButton(
            text: "Update",
            color: TColors.primary,
            onPressed: () async {
              //Show loading spinner
              profileUpdate(_pickedImage);
            },
          )
        ],
      ),
    );
  }
}
