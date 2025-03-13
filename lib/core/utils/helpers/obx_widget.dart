import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget obxWidget({
  required RxBool isLoading,
  required RxList<dynamic> dataList,
  required Widget child,
  required Widget emptyWidget,
}) {
  return Obx(() {
    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (dataList.isEmpty) {
      return emptyWidget;
    } else {
      return child;
    }
  });
}
