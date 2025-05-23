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
import 'package:uniswap/common/widgets/form/custom_text_form_field.dart';
import 'package:uniswap/controllers/auth_controller.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/core/utils/validators/validation.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/features/shop/event/ticket_management_screen/ticket_management_screen.dart';
import 'package:uniswap/models/event_model.dart';
import 'package:uniswap/theme/custom_button_style.dart';

class TicketUploadScreen extends StatefulWidget {
  const TicketUploadScreen({super.key});

  @override
  State<TicketUploadScreen> createState() => _TicketUploadScreenState();
}

class _TicketUploadScreenState extends State<TicketUploadScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController eventByController = TextEditingController();

  final ProductController productController = Get.put(ProductController());
  final Storage storage = Storage(Get.find<Client>());

  DateTime? selectedDate;

  String? selectedCategory;
  String? categoryTitle;
  List<File> _selectedImages = [];
  String? userId;
  String? selectedQty;

  String eventType = "";
  String ticketType = "";

  String? eventDate; // State for Event date
  String? eventTime; // State for event time
  String? startTime; // State for start time
  String? endTime; // State for end time
  String? endSalesDate; // State Sales Date

  GetStorage box = GetStorage();

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

  // EVent Date
  Future<void> _selectEventDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        eventDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  // End Sales EVent Date
  Future<void> _selectEndSalesDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        endSalesDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        endTime = pickedTime.format(context);
      });
    }
  }

  Future<void> uploadItem(context) async {
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

      final AuthController controller = Get.put(AuthController());
      final bool isLoggedIn = await controller.checkSessions();

      // Access individual fields from the user data
      final userId = SavedData.getUserId();

      // Create a new product model
      EventModel newProduct = EventModel(
          userId: userId,
          image: fileIds,
          name: eventNameController.text.trim(),
          price: priceController.text.trim(),
          percentage: percentageController.text.trim(),
          discountPrice: discountPriceController.text.trim(),
          owner: eventByController.text.trim(),
          startTime: startTime,
          endTime: endTime,
          date: eventDate,
          location: locationController.text.trim(),
          phone: phoneNumberController.text.trim(),
          description: descriptionController.text.trim(),
          quantity: qtyController.text.trim(),
          eventType: eventType,
          ticketType: ticketType,
          isApproved: false);

      if (isLoggedIn) {
        // Save the product data to the database
        await productController.saveData(
          Credentials.eventCollectionId,
          newProduct.toJson(),
        );
        EasyLoading.dismiss();

        // Show success message
        TLoaders.toaster(msg: "Success! Your uploaded item is undergoing inspection", bgColor: Colors.green);
        Get.to(() => TicketManagementScreen());
      } else {
        EasyLoading.dismiss();
        // Show error message
        TLoaders.errorSnackBar(title: "Error", message: "You need to be logged in to upload a Ticket");
      }
    } catch (e) {
      EasyLoading.dismiss();
      // Handle errors
      TLoaders.errorSnackBar(title: "Error", message: "Error uploading product");
      print("Error uploading product: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Upload Ticket",
            style: CustomTextStyles.text14wbold,
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24.w),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Images",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF19191B)),
                  ),
                  SizedBox(height: 9.w),
                  Text(
                    "You can add up to 5 pictures for your Ticket",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Color(0xFF64748B)),
                  ),
                  SizedBox(height: 16.w),
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
                        margin: EdgeInsets.only(left: 22.w, top: 12.w, bottom: 12.w),
                        onTap: () => pickImages(), // Call image picker on tap
                      ),
                    ],
                  ),

                  SizedBox(height: 16.w),

                  /// Event NAME
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Name",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        controller: eventNameController,
                        hintText: "Type event name",
                        hintStyle: CustomTextStyles.text12w400,
                        borderDecoration: TextFormFieldStyleHelper.outlineGrey200,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
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

                  // Event time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Date",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          SizedBox(height: 5.h),
                          GFButton(
                            onPressed: () => _selectEventDate(context),
                            text: eventDate ?? "22nd May, 2023",
                            textStyle: TextStyle(color: const Color(0xFF475569), fontSize: 14.sp),
                            icon: Icon(
                              Icons.calendar_month,
                              size: 14.sp,
                            ),
                            color: Colors.white12,
                            textColor: Colors.black,
                            borderSide: const BorderSide(
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 180.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Event By",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            SizedBox(height: 5.h),
                            CustomTextFormField(
                              controller: eventByController,
                              hintText: "The Joy event",
                              hintStyle: CustomTextStyles.text12w400,
                              borderDecoration: TextFormFieldStyleHelper.outlineGrey200,
                              filled: true,
                              fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the event owner";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  // DURATION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Time",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            child: GFButton(
                              onPressed: () => _selectStartTime(context),
                              text: startTime ?? "9:00 AM",
                              textStyle: TextStyle(color: const Color(0xFF475569), fontSize: 14.sp),
                              icon: Icon(
                                Icons.access_time,
                                size: 14.sp,
                              ),
                              color: Colors.white12,
                              textColor: Colors.black,
                              borderSide: const BorderSide(color: Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            child: GFButton(
                              onPressed: () => _selectEndTime(context),
                              text: endTime ?? "11:00 AM",
                              textStyle: TextStyle(color: const Color(0xFF475569), fontSize: 14.sp),
                              icon: Icon(
                                Icons.access_time,
                                size: 14.sp,
                              ),
                              color: Colors.white12,
                              textColor: Colors.black,
                              borderSide: const BorderSide(color: Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // LOCATION
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        // width: 186.w,
                        controller: locationController,
                        hintText: "Ikeja",
                        hintStyle: CustomTextStyles.text12w400,
                        textInputType: TextInputType.text,
                        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a location";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Discription
                  Column(
                    children: [
                      Text(
                        "Event Description",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        controller: descriptionController,
                        hintText: "Type event description",
                        hintStyle: CustomTextStyles.text12w400,
                        maxLines: 5,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 9.h,
                        ),
                        borderDecoration: TextFormFieldStyleHelper.bordergray200R8,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// Event Type
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Type",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChoiceChip(
                            label: Text(
                              "Virtual",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                            selected: eventType == "Virtual", // Check if "Virtual" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  eventType = "Virtual";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            selectedColor: const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            showCheckmark: false,
                          ),
                          ChoiceChip(
                            label: Text(
                              "Hybrid",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            selected: eventType == "Hybrid", // Check if "Used" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  eventType = "Hybrid";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            showCheckmark: false,
                            selectedColor: const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.w),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                          ),
                          ChoiceChip(
                            label: Text(
                              "Physical",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            selected: eventType == "Physical", // Check if "Used" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  eventType = "Physical";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            showCheckmark: false,
                            selectedColor: const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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

                  /// Ticket Type
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket Type",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ChoiceChip(
                            label: Text(
                              "VIP",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color(0XFFFFFFFF),
                                width: 0.2,
                              ),
                            ),
                            selected: ticketType == "VIP", // Check if "Virtual" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  ticketType = "VIP";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            selectedColor: const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            showCheckmark: false,
                          ),
                          SizedBox(width: 30.w),
                          ChoiceChip(
                            label: Text(
                              "Regular",
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            selected: ticketType == "Regular", // Check if "Used" is selected
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  ticketType = "Regular";
                                });
                              }
                            },
                            checkmarkColor: Colors.grey[100],
                            showCheckmark: false,
                            selectedColor: const Color.fromARGB(255, 188, 191, 194),
                            backgroundColor: const Color(0xFFE2E8F0),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                  // PRICE INPUT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Input Ticket Price",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: priceController,
                        hintText: "Type Ticket price",
                        hintStyle: CustomTextStyles.text12w400,
                        textInputType: TextInputType.number,
                        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Price field is required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // DISCOUNT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discounts (optional)",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Percentage (%)",
                                style: CustomTextStyles.text14w400,
                              ),
                              SizedBox(height: 4.h),
                              CustomTextFormField(
                                width: 148.w,
                                controller: percentageController,
                                textInputType: TextInputType.number,
                                borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                                filled: true,
                                fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 34.h, bottom: 12.h),
                            child: Text(
                              "=",
                              style: CustomTextStyles.text12w400,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: CustomTextStyles.text12w400,
                              ),
                              SizedBox(height: 4.h),
                              CustomTextFormField(
                                width: 148.w,
                                controller: discountPriceController,
                                textInputType: TextInputType.number,
                                borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                                filled: true,
                                fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  // QUANTITY
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket Quantity",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        // width: 186.w,
                        controller: qtyController,
                        hintText: "500",
                        hintStyle: CustomTextStyles.text12w400,
                        textInputType: TextInputType.number,
                        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the no of ticket";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  //TICKET SALES END DATE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket Sales End Date",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 150.w,
                        child: GFButton(
                          onPressed: () => _selectEndSalesDate(context),
                          text: endSalesDate ?? "22nd May, 2023",
                          textStyle: TextStyle(color: const Color(0xFF475569), fontSize: 14.sp),
                          icon: Icon(
                            Icons.calendar_month,
                            size: 14.sp,
                          ),
                          color: Colors.white12,
                          textColor: Colors.black,
                          borderSide: const BorderSide(
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Phone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact number",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextFormField(
                        // width: 186.w,
                        controller: phoneNumberController,
                        hintText: "070733425678",
                        hintStyle: CustomTextStyles.text12w400,
                        textInputType: TextInputType.phone,
                        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorTL25,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        validator: TValidator.validatePhoneNumber,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

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
                        TLoaders.warningSnackBar(title: "Warning", message: "Please fill all required fields.");
                        return;
                      }
                      if (_selectedImages.isEmpty) {
                        TLoaders.warningSnackBar(title: "Warning", message: "Please upload an image.");
                        return;
                      }

                      if (eventDate == null && eventTime == null && startTime == null && endTime == null && endSalesDate == null) {
                        TLoaders.warningSnackBar(
                            title: "Warning",
                            message:
                                "Event date, event time, event start time, event end time and event sales date can't be empty, please fill all fields");
                        return;
                      }

                      if (eventType.isEmpty && ticketType.isEmpty) {
                        TLoaders.warningSnackBar(title: "Warning", message: "Please select an event type or ticket type");
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
}
