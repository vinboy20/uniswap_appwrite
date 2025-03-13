import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  // Observable variable for the picked image
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  // Method for picking an image
  Future<void> pickImage({required ImageSource source}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        pickedImage.value = image;
      } else {
        pickedImage.value = null; // No image selected
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Method to remove the picked image
  void removeImage() {
    pickedImage.value = null;
  }
}
