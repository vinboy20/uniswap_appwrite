import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({super.key});

  @override
  State<ChangeLocationScreen> createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        // body: Container(
        //   width: double.maxFinite,
        //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             IconButton(onPressed: () {}, icon: const Icon(Iconsax.arrow_left)),
        //             Expanded(
        //               child: CustomImageView(
        //                 imagePath: TImages.logo,
        //                 height: 56.h,
        //                 width: 113.w,
        //                 alignment: Alignment.center,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 37.h),
        //       _buildSearchSection(context),
        //       SizedBox(height: 38.h),
        //       Text(
        //         "People are searching for",
        //         style: CustomTextStyles.text14w400,
        //       ),
        //       SizedBox(height: 15.h),
        //       _buildContainer1(context),
        //     ],
        //   ),
        // ),

        // body: OpenStreetMapSearchAndPick(
        //   center: LatLong(23, 89),
        //   buttonText: 'Set Current Location',
        //   buttonColor: Colors.blue,
        //   onPicked: (pickedData) {
        //     print(pickedData.latLong.latitude);
        //     print(pickedData.latLong.longitude);
        //     print(pickedData.address);
        //   },
        // ),
        // body: FlutterLocationPicker(
        //   initPosition: LatLong(23, 89),
        //   selectLocationButtonStyle: ButtonStyle(
        //     backgroundColor: WidgetStateProperty.all(Colors.blue),
        //   ),
        //   selectedLocationButtonTextStyle: const TextStyle(fontSize: 18),
        //   selectLocationButtonText: 'Set Current Location',
        //   selectLocationButtonLeadingIcon: const Icon(Icons.check),
        //   initZoom: 11,
        //   minZoomLevel: 5,
        //   maxZoomLevel: 16,
        //   trackMyPosition: true,
        //   onError: (e) => print(e),
        //   onPicked: (pickedData) {
        //     print(pickedData.latLong.latitude);
        //     print(pickedData.latLong.longitude);
        //     print(pickedData.address);
        //     print(pickedData.addressData['country']);
        //   },
        //   onChanged: (pickedData) {
        //     print(pickedData.latLong.latitude);
        //     print(pickedData.latLong.longitude);
        //     print(pickedData.address);
        //     print(pickedData.addressData);
        //   },
        // ),
        body: MapLocationPicker(
          initialLatitude: 6.5244,
          initialLongitude:  3.3792,
          buttonText: "Get Location",
          buttonColor: Colors.white,
          // buttonTextStyle:TextStyle(height: 10),
          onPicked: (result) {
            // you can get the location result here
            print(result.completeAddress);
            print(result.latitude);
            print(result.longitude);
          },
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildSearchSection(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: locationController,
  //     hintText: "Type location...",
  //     hintStyle: CustomTextStyles.text12w400,
  //     textInputAction: TextInputAction.done,
  //     contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 19.h),
  //     borderDecoration: OutlineInputBorder(borderSide: const BorderSide(color: TColors.gray50), borderRadius: BorderRadius.circular(50.w)),
  //     filled: true,
  //     fillColor: TColors.softGrey,
  //   );
  // }

  /// Section Widget
  // Widget _buildContainer1(BuildContext context) {
  //   return Expanded(
  //     child: ListView.separated(
  //       physics: const BouncingScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return SizedBox(
  //           height: 24.h,
  //         );
  //       },
  //       itemCount: 2,
  //       itemBuilder: (context, index) {
  //         return const ContainerItemWidget();
  //       },
  //     ),
  //   );
  // }
}
