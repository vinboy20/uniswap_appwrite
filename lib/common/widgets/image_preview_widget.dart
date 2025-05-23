import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';

class FilePreviewImage extends StatelessWidget {
  final String bucketId;
  final String fileId;
  final double width;
  final double height;
  final double borderRadius;
  final BorderRadiusGeometry? imageborderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget? fallbackWidget;
  final bool isCircular;

  const FilePreviewImage({
    super.key,
    required this.bucketId,
    required this.fileId,
    this.width = 65,
    this.height = 65,
    this.borderRadius = 0.0,
    this.imageborderRadius,
    this.placeholder,
    this.errorWidget,
    this.fallbackWidget,
    this.isCircular = true,
  });

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage(Get.find<Client>());
    // Handle empty or invalid fileId
    if (fileId.isEmpty) {
      return fallbackWidget ??
          Icon(
            Icons.image_not_supported,
            size: height,
            color: Colors.grey,
          );
    }
    // return Image.network(
    //   "${Credentials.imageApiEndpoint}/storage/buckets/$bucketId/files/$fileId/view?project=${Credentials.projectID}&mode=admin",
    //   headers: {"Origin": "*"}, // Add this line
    //   loadingBuilder: (context, child, loadingProgress) {
    //     if (loadingProgress == null) return child;
    //     return TShimmerEffect(
    //       width: width,
    //       height: height,
    //       // radius: borderRadius,
    //     );
    //   },
    //    width: width,
    //   height: height,
    //   fit: BoxFit.cover,
    //   errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
    // );

    return FutureBuilder(
      future: storage.getFilePreview(
        bucketId: bucketId,
        fileId: fileId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show shimmer effect or custom placeholder
          return placeholder ??
              TShimmerEffect(
                width: width,
                height: height,
                radius: borderRadius,
              );
        } else if (snapshot.hasError) {
          // Handle error state with custom error widget
          return errorWidget ??
              Icon(
                Icons.error,
                size: height,
                color: Colors.red,
              );
        } else if (snapshot.hasData && snapshot.data != null) {
          // When data is available, show the image
          final image = Image.memory(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
          // return ClipRRect(
          //    borderRadius: imageborderRadius!,
          //   child: Image.memory(
          //     snapshot.data!,
          //     height: height,
          //     width: width,
          //     fit: BoxFit.cover,
          //   ),
          // );

          return isCircular
              ? ClipOval(child: image)
              : ClipRRect(
                  // borderRadius: BorderRadius.circular(borderRadius),
                  borderRadius: imageborderRadius!,
                  child: image,
                );
        } else {
          // Fallback for any other unexpected state
          return fallbackWidget ??
              Icon(
                Icons.image_not_supported,
                size: height,
                color: Colors.grey,
              );
        }
      },
    );
  }
}
