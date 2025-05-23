import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/image_picker_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/features/authentication/screens/bvn_screen/bvn_screen.dart';

class NinScreen extends StatefulWidget {
  const NinScreen({super.key});

  @override
  State<NinScreen> createState() => _NinScreenState();
}

class _NinScreenState extends State<NinScreen> {

  final GetStorage storage = GetStorage();
  final controller = Get.put(AuthController());

   Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await THelperFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        controller.pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        controller.pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          controller.pickedImage = null;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          leadingOnPressed: () {
            Navigator.pop(context);
          },
          showBackArrow: true,
          title: const Text("Personal Details"),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 5.h),
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          width: THelperFunctions.screenWidth(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 54.h,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  width: 70.w,
                  decoration: TAppDecoration.outlineBlack.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 28.h,
                        width: 28.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 25.w,
                                width: 25.w,
                                child: const CircularProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: TColors.grey,
                                  color: TColors.primary,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "100%",
                                style: TextStyle(fontSize: 8.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Profile strength",
                        style: TextStyle(fontSize: 8.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),

              // Image Picker
              PickImageWidget(
                pickedImage: controller.pickedImage,
                function: () async {
                  await localImagePicker();
                },
              ),
              SizedBox(height: 18.h),
              Text(
                "Upload picture",
                style: CustomTextStyles.text16w400,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Text(
                "NIN ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 14.h),
              Text(
                "This information is needed for enhancing security, reducing fraud, and complying with regulatory requirements.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.text14w400,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Input NIN",
                    style: CustomTextStyles.text14w600cPrimary,
                  ),
                  SizedBox(height: 4.h),
                  // Form
                  Form(
                    key: controller.ninFormKey,
                    child: CustomTextFormField(
                      controller: controller.nin,
                      hintText: "0",
                      hintStyle: CustomTextStyles.text12w400,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
                      borderDecoration: TextFormFieldStyleHelper.outlineGrey200,
                      filled: true,
                      fillColor: TColors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "nin field is required";
                        } else if (value.length < 10 || value.length > 10) {
                          return "max of 10 character is required";
                        }
                        return null;
                      },
                    ),
                  ),
                
                ],
              ),
              SizedBox(height: 19.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const BvnScreen());
                },
                child: Text(
                  "Use BVN instead",
                  style: CustomTextStyles.text14w400cPrimary,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),
             CustomPillButton(
                color: TColors.primary,
                onPressed: () async {
                  if (!controller.ninFormKey.currentState!.validate()) {
                    return;
                  } else if (controller.pickedImage == null) {
                    Get.snackbar("Error", "Please upload your NIN");
                  } else {
                    controller.ninUpload(context);
                    EasyLoading.dismiss();
                  }
                },
                text: "Next",
              ),
            ],
          ),
        ),
      ),
    );
  }


}
