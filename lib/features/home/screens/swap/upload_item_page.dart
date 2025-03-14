import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/appbar/appbar.dart';
import 'package:uniswap/common/widgets/button/custom_elevated_button.dart';
import 'package:uniswap/common/widgets/custom_dash_line_painter.dart';
import 'package:uniswap/common/widgets/custom_drop_down.dart';
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/common/widgets/loaders/shimmer.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/core/utils/validators/validation.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/models/product_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class UploadItemPage extends StatefulWidget {
  const UploadItemPage({super.key});

  @override
  State<UploadItemPage> createState() => _UploadItemPageState();
}

class _UploadItemPageState extends State<UploadItemPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController startPriceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController moreController = TextEditingController();

  final ProductController productController = Get.put(ProductController());
  final Storage storage = Storage(Get.find<Client>());

  DateTime? selectedDate;

  String? selectedCategory;
  String? categoryTitle;
  List<File> _selectedImages = [];
  String? userId;
  String? selectedQty;

  String? selectedLocation;

  String productCondition = "";

  String? bidEndDate; // State for bid end date
  String? bidEndTime; // State for bid end time

  GetStorage box = GetStorage();

  List<String> dropdownItemList = [
    "1",
    "2",
    "3",
    "4",
  ];

  List<String> dropdownItemList1 = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  List<String> dropdownItemList2 = [
    "Uniben",
    "University Of Lagos",
    "Laspotech",
  ];

  List<String> dropdownItemList3 = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final int maxImages = 4; // Maximum allowed images

  // Method to pick multiple images
  Future<void> pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();

    if (images != null) {
      // Combine existing and newly selected images
      final newImages = images.map((image) => File(image.path)).toList();

      // Check if adding the new images exceeds the limit
      if (_selectedImages.length + newImages.length > maxImages) {
        // Show an error or only take up to the limit
        final availableSlots = maxImages - _selectedImages.length;
        if (availableSlots > 0) {
          newImages.removeRange(availableSlots, newImages.length);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You can select a maximum of $maxImages images."),
          ),
        );
      }

      setState(() {
        _selectedImages.addAll(newImages);
        // Ensure we don't exceed the limit
        _selectedImages = _selectedImages.take(maxImages).toList();
      });
    }
  }

  bool isFixedPrice = true;

  void toggleSaleType(bool isFixed) {
    setState(() {
      isFixedPrice = isFixed;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        bidEndDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        bidEndTime = pickedTime.format(context);
      });
    }
  }

  Future<void> chooseCategory(BuildContext context) async {
    final categories = productController.categories;
    final subcategories = productController.subcategories;
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choose Category",
                        style: CustomTextStyles.text14w600cPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      // Filter subcategories based on catId
                      final categorySubcategories = subcategories
                          .where((sub) => sub.catId == category.docId)
                          .toList();

                      return Column(
                        children: [
                          SizedBox(
                            child: GFAccordion(
                              titleChild: Row(
                                children: [
                                  Opacity(
                                    opacity: 0.8,
                                    child: FutureBuilder(
                                      future: storage.getFilePreview(
                                        bucketId: Credentials.categoryBucketId,
                                        fileId: category.image!,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return TShimmerEffect(
                                            width: 25.w,
                                            height: 25.h,
                                          );
                                        } else if (snapshot.hasError) {
                                          return Icon(
                                            Icons.error,
                                            size: 65.h,
                                            color: Colors.red,
                                          );
                                        } else if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return ClipOval(
                                            child: Image.memory(
                                              snapshot.data!,
                                              height: 25.h,
                                              width: 25.2,
                                            ),
                                          );
                                        } else {
                                          return Icon(
                                            Icons.image_not_supported,
                                            size: 65.h,
                                            color: Colors.grey,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(category.title ?? "No Title"),
                                ],
                              ),
                              expandedTitleBackgroundColor: Colors.white,
                              contentBackgroundColor: Color(0xFFF8FAFC),
                              // collapsedTitleBackgroundColor: Color(0xFFF8FAFC),
                              contentChild: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: categorySubcategories
                                    .length, // Filtered count
                                separatorBuilder:
                                    (BuildContext context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemBuilder: (BuildContext context, index) {
                                  var subcat = categorySubcategories[
                                      index]; // Filtered list

                                  return GestureDetector(
                                    onTap: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          selectedCategory = subcat.catId;
                                          categoryTitle = subcat.title;
                                        });
                                      });
                                      box.write('category', subcat.catId);
                                      box.write('subcategory', subcat.docId);
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Text(subcat.title ?? "No Title"),
                                    ),
                                  );
                                },
                              ),
                              collapsedIcon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 18.sp,
                              ),
                              expandedIcon: Icon(
                                Icons.keyboard_arrow_up,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.0, // Thickness of the dashed line
                            width: double.infinity,
                            child: CustomPaint(
                              painter: CustomDashLinePainter(
                                dashWidth: 5.0.w,
                                dashSpace: 3.0.h,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadItem(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    EasyLoading.show(status: 'Uploading...');

    try {
      // Upload images and collect file IDs
      List<String> fileIds = [];
      for (var file in _selectedImages) {
        final XFile xFile = XFile(file.path);
        final fileId = await productController.uploadMultipleImage(
          Credentials.productBucketId,
          xFile,
        );
        fileIds.add(fileId);
      }

      String catId = box.read('category') ?? "";
      String subcatId = box.read('subcategory') ?? "";
      final AuthController controller = Get.put(AuthController());
      final bool isLoggedIn = await controller.checkSessions();

      // Access individual fields from the user data
      final userId = SavedData.getUserId();

      bool? isBid;
      if (bidEndDate == null && bidEndTime == null) {
        isBid = false;
      } else {
        isBid = true;
      }

      // Create a new product model
      ProductModel newProduct = ProductModel(
        catId: catId,
        subcatId: subcatId,
        userId: userId,
        image: fileIds,
        productName: productNameController.text.trim(),
        productCondition: productCondition,
        startPrice: startPriceController.text.trim(),
        percentage: percentageController.text.trim(),
        discountPrice: discountPriceController.text.trim(),
        bidEndDate: bidEndDate.toString(),
        bidEndTime: bidEndTime.toString(),
        location: selectedLocation,
        phone: phoneNumberController.text.trim(),
        description: descriptionController.text.trim(),
        productQty: selectedQty.toString(),
        moreSpec: moreController.text.trim(),
        isBid: isBid,
      );

      if (isLoggedIn) {
        // Save the product data to the database
        await productController.saveData(
          Credentials.productCollectionId,
          newProduct.toJson(),
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product uploaded successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UploadItemPage(), // Replace with your screen widget
          ),
        );
        box.remove('category');
        box.remove('subcategory');

        await productController.fetchProducts();
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("You need to be logged in to upload a product")),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      print("Error uploading product: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TAppBar(
          title: Text(
            "Upload Product",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 36.w),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Images",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF19191B)),
                  ),
                  SizedBox(height: 9.w),
                  Text(
                    "You can add up to 5 pictures for your product",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF64748B)),
                  ),
                  SizedBox(height: 15.w),
                  // multiple Image upload

                  Row(
                    children: [
                      Row(
                        children: _selectedImages.map((file) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.file(
                              file,
                              height: 49.w,
                              width: 49.w,
                            ),
                          );
                        }).toList(),
                      ),
                      CustomImageView(
                        imagePath: TImages.plusIcon,
                        height: 24.w,
                        width: 24.w,
                        margin: EdgeInsets.only(
                            left: 22.w, top: 12.w, bottom: 12.w),
                        onTap: () => pickImages(), // Call image picker on tap
                      ),
                    ],
                  ),

                  SizedBox(height: 17.w),

                  // CATEGORY
                  Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF19191B)),
                  ),
                  SizedBox(height: 9.h),
                  SizedBox(
                    height: 1.0, // Thickness of the dashed line
                    width: double.infinity,
                    child: CustomPaint(
                      painter: CustomDashLinePainter(
                        dashWidth: 3.0,
                        dashSpace: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 9.h),
                  GestureDetector(
                    onTap: () => chooseCategory(context),
                    child: Row(
                      children: [
                        Text(
                          categoryTitle == null ? "Choose" : categoryTitle!,
                          style: CustomTextStyles.text12w400,
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                  SizedBox(height: 9.h),
                  SizedBox(
                    height: 1.0, // Thickness of the dashed line
                    width: double.infinity,
                    child: CustomPaint(
                      painter: CustomDashLinePainter(
                        dashWidth: 3.0,
                        dashSpace: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  /// PRODUCT NAME
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        controller: productNameController,
                        hintText: "Type item name",
                        hintStyle: CustomTextStyles.text12w400,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineGrey200,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product Name field is required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  /// CONDITION
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Condition",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ChoiceChip(
                            label: Text(
                              "New",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF475569)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                            selected: productCondition ==
                                "New", // Check if "New" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  productCondition = "New";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            selectedColor:
                                const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            showCheckmark: false,
                          ),
                          SizedBox(width: 40),
                          ChoiceChip(
                            label: Text(
                              "Used",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF475569)),
                            ),
                            selected: productCondition ==
                                "Used", // Check if "Used" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  productCondition = "Used";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            showCheckmark: false,
                            selectedColor:
                                const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Describe Product",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475569)),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: descriptionController,
                    hintText: "Type product description",
                    hintStyle: CustomTextStyles.text12w400,
                    maxLines: 5,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    borderDecoration: TextFormFieldStyleHelper.bordergray200R8,
                    filled: true,
                    fillColor:
                        theme.colorScheme.onPrimaryContainer.withOpacity(1),
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Quantity",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 8.h),
                      CustomDropDown(
                        width: 139.w,
                        icon: Icon(Icons.keyboard_arrow_down),
                        hintText: "Qty",
                        hintStyle: TextStyle(fontSize: 12.sp),
                        items: dropdownItemList,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        borderDecoration:
                            DropDownStyleHelper.outlineOnErrorTL22,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        onChanged: (value) {
                          setState(() {
                            selectedQty = value;
                          });
                        },
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    "Sale type",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475569)),
                  ),
                  SizedBox(height: 5.h),

                  /// SALE TYPE
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChoiceChip(
                            label: const Text("Up for bid"),
                            selected: !isFixedPrice,
                            onSelected: (isSelected) {
                              if (isSelected) toggleSaleType(false);
                            },
                            selectedColor: Color.fromARGB(255, 188, 191, 194),
                            showCheckmark: false,
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          ChoiceChip(
                            label: const Text("Fixed price"),
                            selected: isFixedPrice,
                            onSelected: (isSelected) {
                              if (isSelected) toggleSaleType(true);
                            },
                            selectedColor: Color.fromARGB(255, 188, 191, 194),
                            showCheckmark: false,
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 26.h),

                  // Conditional Inputs
                  isFixedPrice
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Input Start Price",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF475569)),
                                ),
                                SizedBox(height: 4.h),
                                CustomTextFormField(
                                  controller: startPriceController,
                                  hintText: "Type item start price",
                                  hintStyle: CustomTextStyles.text12w400,
                                  borderDecoration: TextFormFieldStyleHelper
                                      .outlineOnErrorTL25,
                                  filled: true,
                                  fillColor: theme
                                      .colorScheme.onPrimaryContainer
                                      .withOpacity(1),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Start Price field is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discounts (optional)",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF475569)),
                                ),
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Percentage (%)",
                                          style: CustomTextStyles.text14w400,
                                        ),
                                        SizedBox(height: 4.h),
                                        CustomTextFormField(
                                          width: 148.w,
                                          controller: percentageController,
                                          borderDecoration:
                                              TextFormFieldStyleHelper
                                                  .outlineOnErrorTL25,
                                          filled: true,
                                          fillColor: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(1),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 34.h, bottom: 12.h),
                                      child: Text(
                                        "=",
                                        style: CustomTextStyles.text12w400,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: CustomTextStyles.text12w400,
                                        ),
                                        SizedBox(height: 4.h),
                                        CustomTextFormField(
                                          width: 148.w,
                                          controller: discountPriceController,
                                          borderDecoration:
                                              TextFormFieldStyleHelper
                                                  .outlineOnErrorTL25,
                                          filled: true,
                                          fillColor: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Input Start Price",
                                  style: CustomTextStyles.text12w400,
                                ),
                                SizedBox(height: 4.h),
                                CustomTextFormField(
                                  controller: startPriceController,
                                  hintText: "Type item start price",
                                  hintStyle: CustomTextStyles.text12w400,
                                  borderDecoration: TextFormFieldStyleHelper
                                      .outlineOnErrorTL25,
                                  filled: true,
                                  fillColor: theme
                                      .colorScheme.onPrimaryContainer
                                      .withOpacity(1),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount(optional)",
                                  style: CustomTextStyles.text14w400,
                                ),
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Percentage (%)",
                                          style: CustomTextStyles.text14w400,
                                        ),
                                        SizedBox(height: 4.h),
                                        CustomTextFormField(
                                          width: 148.w,
                                          controller: percentageController,
                                          borderDecoration:
                                              TextFormFieldStyleHelper
                                                  .outlineOnErrorTL25,
                                          filled: true,
                                          fillColor: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(1),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 34.h, bottom: 12.h),
                                      child: Text(
                                        "=",
                                        style: CustomTextStyles.text14w400,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: CustomTextStyles.text14w400,
                                        ),
                                        SizedBox(height: 4.h),
                                        CustomTextFormField(
                                          width: 148.w,
                                          controller: discountPriceController,
                                          borderDecoration:
                                              TextFormFieldStyleHelper
                                                  .outlineOnErrorTL25,
                                          filled: true,
                                          fillColor: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bid end date",
                                      style: CustomTextStyles.text14w400,
                                    ),
                                    SizedBox(height: 5.h),
                                    SizedBox(
                                      child: GFButton(
                                        onPressed: () => _selectDate(context),
                                        text: bidEndDate ?? "Select Date",
                                        textStyle: TextStyle(
                                            color: const Color(0xFF475569),
                                            fontSize: 14.adaptSize),
                                        icon: Icon(
                                          Icons.calendar_month,
                                          size: 14.sp,
                                        ),
                                        color: Colors.white12,
                                        textColor: Colors.black,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF94A3B8),
                                        ),
                                        shape: GFButtonShape.pills,
                                        size: GFSize.LARGE,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bid end Time",
                                      style: CustomTextStyles.text14w400,
                                    ),
                                    SizedBox(height: 5.h),
                                    SizedBox(
                                      child: GFButton(
                                        onPressed: () => _selectTime(context),
                                        text: bidEndTime ?? "Select Time",
                                        textStyle: TextStyle(
                                            color: const Color(0xFF475569),
                                            fontSize: 14.sp),
                                        icon: Icon(
                                          Icons.access_time,
                                          size: 14.sp,
                                        ),
                                        color: Colors.white12,
                                        textColor: Colors.black,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF94A3B8)),
                                        shape: GFButtonShape.pills,
                                        size: GFSize.LARGE,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          
                          ],
                        ),

                  // _buildBidenddate(context),
                  SizedBox(height: 24.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: CustomTextStyles.text14w400,
                      ),
                      SizedBox(height: 5.h),
                      CustomDropDown(
                        width: 200.w,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        hintText: "Select Location",
                        items: dropdownItemList2,
                        prefix: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.add_location_outlined),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 44.h,
                        ),
                        borderDecoration: DropDownStyleHelper.outlineOnErrorTL8,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value;
                          });
                        },
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Phone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone number",
                        style: CustomTextStyles.text14w400,
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        // width: 186.w,
                        controller: phoneNumberController,
                        // hintText: "070733425678",
                        hintStyle: CustomTextStyles.text12w400,
                        textInputType: TextInputType.phone,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: TValidator.validatePhoneNumber,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  GFAccordion(
                    margin: EdgeInsets.zero,
                    titleChild: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'More Specification',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF475569)),
                      ),
                    ),
                    //collapsedTitleBackgroundColor: Colors.transparent,
                    contentChild: CustomTextFormField(
                      controller: moreController,
                      hintText: "Type product description",
                      hintStyle: CustomTextStyles.text12w400,
                      maxLines: 5,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 9.h,
                      ),
                      borderDecoration:
                          TextFormFieldStyleHelper.bordergray200R8,
                      // filled: true,
                      fillColor:
                          theme.colorScheme.onPrimaryContainer.withOpacity(1),
                    ),
                    titleBorderRadius: BorderRadius.circular(20),
                    titleBorder:
                        Border.all(color: Color(0xFF000000), width: 0.5),
                    collapsedIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 18.sp,
                    ),
                    expandedIcon: Icon(
                      Icons.keyboard_arrow_up,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Upload Button
                  CustomElevatedButton(
                    height: 44.h,
                    text: "Post Now",
                    buttonStyle: CustomButtonStyles.fillTeal,
                    buttonTextStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        TLoaders.warningSnackBar(
                            title: "Warning",
                            message: "Please fill all required fields.");
                        return;
                      }
                      if (_selectedImages.isEmpty) {
                        TLoaders.warningSnackBar(
                            title: "Warning",
                            message: "Please upload an image.");
                        return;
                      }
                      if (selectedCategory == null) {
                        TLoaders.warningSnackBar(
                            title: "Warning",
                            message: "Please select a category.");
                        return;
                      }
                      if (productCondition.isEmpty) {
                        TLoaders.warningSnackBar(
                            title: "Warning",
                            message: "Please choose a product condition.");
                        return;
                      }

                      // // Call the upload method
                      await uploadItem(context);

                      // print(catsub);
                    },
                  ),
                  SizedBox(height: 24.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void datePickerDiolog(BuildContext context) {
  //   showDatePicker(
  //     context: context,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2030),
  //   );
  // }

  // void timePickerDiolog(BuildContext context) {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  // }
}
