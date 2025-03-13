// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uniswap/core/app_export.dart';
class FaceId extends StatefulWidget {
  const FaceId({super.key});

  @override
  State<FaceId> createState() => _FaceIdState();
}

class _FaceIdState extends State<FaceId> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopup(context);
      },
      child: Text(
        "Facial recognition",
        style: CustomTextStyles.text14w400cPrimary,
      ),
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
          title: Text(
            "Do you want to allow “UniSwap” to use Face ID",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.text16w400,
          ),
          content: Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "Allow Face ID to authenticate on UniSwap",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.text14w400,
                  ),
                ),
                SizedBox(height: 8.h),
                const Divider(color: TColors.darkGrey, thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Don’t Allow",
                        style: CustomTextStyles.text14w400cBlue,
                      ),
                    ),
                    Container(
                      width: 80.w,
                      margin: EdgeInsets.only(left: 32.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 47.h,
                            child: VerticalDivider(
                              width: 1.w,
                              thickness: 1,
                              color: TColors.darkGrey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _timer?.cancel();
                              await EasyLoading.showSuccess('Face ID');
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Allow",
                              style: CustomTextStyles.text14w400cBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
