import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/validators/validation.dart';
import 'package:uniswap/data/saved_data.dart';

class ProfileFormReg extends StatefulWidget {
  const ProfileFormReg({super.key});

  @override
  State<ProfileFormReg> createState() => _ProfileFormRegState();
}

class _ProfileFormRegState extends State<ProfileFormReg> {
  final _controller = Get.find<AuthController>();

  XFile? _pickedImage;
  bool profileLoading = false;

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

  @override
  Widget build(BuildContext context) {
    // Retrieve the entire user data map
    final userData = SavedData.getUserData();
    // Access individual fields
    final email = userData['email'];
    String username = userData['name'];
    final avatar = userData['avatar'];

    TextEditingController fullNameController = TextEditingController(text: username);
    TextEditingController emailController = TextEditingController(text: email);
    return Form(
      key: _controller.profileFormKey,
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
                    ? CustomImageView(
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
                          fit: BoxFit.cover, // Use cover to maintain aspect ratio while filling
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
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
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
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
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
                controller: _controller.phoneController,
                hintText: "phone number",
                hintStyle: CustomTextStyles.text12w400,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.phone,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
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
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _controller.selectedDate.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null) {
                    _controller.updateSelectedDate(pickedDate);
                  }
                },
                child: Obx(() {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 17.h),
                    decoration: ShapeDecoration(
                      color: TColors.gray50,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFFFFFFFF)),
                        borderRadius: BorderRadius.circular(50.w),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            _controller.formattedDate,
                            style: CustomTextStyles.text12w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          DropdownButtonHideUnderline(
            child: Obx(() {
              return DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Gender',
                  style: CustomTextStyles.text12w400.copyWith(
                    height: 1.43,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                items: _controller.genderItem
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: CustomTextStyles.text12w400.copyWith(
                              height: 1.43,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: _controller.selectedGenderValue.value,
                onChanged: (value) {
                  _controller.updateSelectedValue(value);
                },
                buttonStyleData: ButtonStyleData(
                  height: 50.h,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xFFF1F5F9),
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.expand_more,
                  ),
                  iconSize: 25.sp,
                  iconEnabledColor: Colors.grey,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.w),
                      bottomRight: Radius.circular(10.w),
                    ),
                    color: Colors.white,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: Radius.circular(40.w),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 40.h,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                ),
              );
            }),
          ),
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bio (optional)", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: _controller.bioController,
                hintText: "Biography",
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.text,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
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
              Text("Add relevant link (optional)", style: CustomTextStyles.text14w400),
              SizedBox(height: 5.h),
              CustomTextFormField(
                controller: _controller.linkController,
                hintText: "Link",
                hintStyle: CustomTextStyles.text12w400,
                textInputType: TextInputType.text,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
                borderDecoration: TextFormFieldStyleHelper.outlineOnError,
                filled: true,
                fillColor: TColors.softGrey,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          CustomPillButton(
            text: "Register Now",
            color: TColors.primary,
            onPressed: () async {
              //Show loading spinner
              _controller.profileUpdate(_pickedImage);
            },
          )
        ],
      ),
    );
  }
}
