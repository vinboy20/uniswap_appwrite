import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingObserver<T> extends StatelessWidget {
  final RxBool isLoading;
  final RxList<T> dataList;
  final RxString errorMessage;
  final Widget Function() child;
  final Widget emptyWidget;
  final bool showToastError;

  const LoadingObserver({
    super.key,
    required this.isLoading,
    required this.dataList,
    required this.errorMessage,
    required this.child,
    required this.emptyWidget,
    this.showToastError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (errorMessage.isNotEmpty) {
        if (showToastError) {
          EasyLoading.showError(errorMessage.value);
          Future.delayed(Duration(seconds: 2), () {
            errorMessage.value = ''; // Clear error after showing toast
          });
          return const SizedBox(); // Prevents rendering error message on UI
        } else {
          return Center(
            child: Text(errorMessage.value, style: const TextStyle(color: Colors.red, fontSize: 16)),
          );
        }
      } else if (dataList.isEmpty) {
        return emptyWidget;
      } else {
        return child();
      }
    });
  }
}
