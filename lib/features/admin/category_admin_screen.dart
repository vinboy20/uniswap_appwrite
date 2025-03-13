import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniswap/common/widgets/image_picker_widget.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/features/admin/subcategory.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/models/category.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';

class CategoryAdminScreen extends StatefulWidget {
  const CategoryAdminScreen({
    super.key,
    // this.categoryId,
    // this.initialTitle,
    // this.initialImage,
  });
  // final String? categoryId; // Pass this for updating an existing category
  // final String? initialTitle;
  // final String? initialImage;

  @override
  State<CategoryAdminScreen> createState() => _CategoryAdminScreenState();
}

class _CategoryAdminScreenState extends State<CategoryAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
   final ProductController productController = Get.put(ProductController());
  XFile? _pickedImage;
  @override
  void initState() {
    super.initState();
    // Initialize the provider once
    // productProvider = Provider.of<ProductProvider>(context, listen: false);
    _loadData();
  }

  Future<void> _loadData() async {
    await productController.fetchCategories();
  }

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // title: Text(widget.categoryId == null ? "Create Category" : "Update Category"),
        title: Text("Create Category"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(HomeContainer());
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PickImageWidget(
                pickedImage: _pickedImage,
                function: () async {
                  await localImagePicker();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Title is required";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Wrap(spacing: 4, children: [
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        EasyLoading.show(status: 'Saving...');
                        // final provider = Provider.of<ProductProvider>(context, listen: false);
                        String? fileId;
        
                        try {
                          if (_pickedImage != null) {
                            fileId = await productController.uploadImage(Credentials.categoryBucketId, _pickedImage!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("upload a image")),
                            );
                          }
        
                          if (fileId != null) {
                            CategoryModel newCategory = CategoryModel(
                              title: _titleController.text.trim(),
                              image: fileId,
                            );
                            await productController.saveData(Credentials.categoryCollectionId, newCategory.toJson());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Category added successfully!")),
                            );
        
                            _pickedImage = null;
                            _titleController.text = "";
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error uploading category")),
                            );
                          }
                          // Navigator.pop(context); // Go back to the previous screen
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                          print(e.toString());
                        } finally {
                          EasyLoading.dismiss();
                        }
                      }
                    },
                    // child: Text(widget.categoryId == null ? "Create" : "Update"),
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 153.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(productController.categories);
                      Get.off(Subcategory());
                    },
                    // child: Text(widget.categoryId == null ? "Create" : "Update"),
                    child: Text(
                      "Create SubCategory",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 30.h),
              // categoryWidget(context, productProvider.categories),
            ],
          ),
        ),
      ),
    );
  }
}
