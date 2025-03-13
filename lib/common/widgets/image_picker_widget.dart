import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/core/app_export.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, this.pickedImage, required this.function});
  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74.h,
      width: 74.w,
      child: Stack(
        children: [
          pickedImage == null
              ? Container(
                  height: 74.h,
                  width: 74.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.w),
                    color: Colors.grey[100],
                  ),

                  // child: const Icon(Icons.cloud_upload_rounded, size: 50,),
                )
              : ClipOval(
                  child: Image.file(
                    File(pickedImage!.path),
                    height: 74.h,
                    width: 74.w,
                    fit: BoxFit.cover, // Use cover to maintain aspect ratio while filling
                  ),
                ),
          Positioned(
            right: -10.w,
            bottom: -15.h,
            child: IconButton(
              onPressed: () {
                function();
              },
              icon: Icon(
                Icons.cloud_upload_rounded,
                size: 20.sp,
                color: TColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
