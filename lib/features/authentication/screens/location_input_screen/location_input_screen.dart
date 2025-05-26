import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uniswap/common/widgets/button/custom_outlined_button.dart';
import 'package:uniswap/common/widgets/button/custom_pill_button.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/core/app_export.dart';

class LocationInputScreen extends StatefulWidget {
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          height: double.infinity,
          //padding: EdgeInsets.symmetric(vertical: 33.h),
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: Column(
                  children: [
                    SizedBox(height: 37.h),
                    CustomImageView(
                      imagePath: TImages.logo,
                      height: 56.h,
                      width: 113.w,
                    ),
                    Text(
                      "Welcome!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 340.w,
                      margin: const EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        "Input location to help you better connect with other users ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.text14w400.copyWith(
                          height: 1.43,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // google map section
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    const SizedBox(
                      child: Icon(Icons.add_location_outlined),
                    ),
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: Container(
                        //height: 250.h,
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 23.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 56.h,
                                child: CustomTextFormField(
                                  autofocus: false,
                                  //controller: passwordController,
                                  hintText: "Type location",
                                  textInputAction: TextInputAction.done,
                                  // prefix: Container(
                                  //   margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 18.h),
                                  //   child: CustomImageView(
                                  //     imagePath: ImageConstant.imgIconOutlineEye,
                                  //     height: 20.adaptSize,
                                  //     width: 20.adaptSize,
                                  //   ),
                                  // ),
                                  prefixConstraints: BoxConstraints(maxHeight: 56.h),
                                  obscureText: true,
                                  borderDecoration: OutlineInputBorder(
                                    borderSide: const BorderSide(color: TColors.primary),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  filled: true,
                                  fillColor: TColors.gray50,
                                )),
                            SizedBox(height: 24.h),
                            CustomOutlinedButton(
                              height: 56.h,
                              text: "Use Current Location",
                              leftIcon: Container(
                                margin: EdgeInsets.only(right: 8.h),
                                child: const Icon(Icons.add_location_outlined),
                              ),
                              // buttonStyle: CustomButtonStyles,
                            ),
                            SizedBox(height: 24.h),
                            CustomPillButton(
                              onPressed: () {},
                              text: "Continue",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //_buildMap(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  // ignore: unused_element
  Widget _buildMap(BuildContext context) {
    return SizedBox(
      //height: 314.h,
      height: 280.h,
      width: double.maxFinite,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            37.43296265331129,
            -122.08832357078792,
          ),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          //googleMapController.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }
}
