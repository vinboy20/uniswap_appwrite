import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/controllers/product_controller.dart';
import 'package:uniswap/models/sub_category.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';

class Subcategory extends StatefulWidget {
  const Subcategory({super.key});

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  // Declare once as a field

  String? selectedCategoryId;

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final categories = productController.categories;
    final subcategories = productController.subcategories;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create SubCategory"),
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
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Title is required";
                  return null;
                },
              ),
              const SizedBox(height: 20),
             
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: false,
                  hint: Text(
                    'Choose Category',
                    style: CustomTextStyles.text12w400.copyWith(
                      height: 1.43,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.docId,
                      child: Text(category.title ?? 'No Title'),
                    );
                  }).toList(),
                  value: selectedCategoryId,
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                  // validator: (value) => value == null ? 'Required' : null,
                  buttonStyleData: ButtonStyleData(
                    height: 50.h,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFFF1F5F9),
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Icon(
                      Icons.expand_more,
                    ),
                    iconSize: 25.sp,
                    iconEnabledColor: Colors.grey,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w),
                        bottomRight: Radius.circular(10.w),
                      ),
                      color: Colors.white,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: Radius.circular(40.w),
                      thickness: WidgetStateProperty.all(6),
                      thumbVisibility: WidgetStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    height: 40.h,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'Saving...');
                      try {
                        SubCategoryModel newSubcategory = SubCategoryModel(
                          title: _titleController.text.trim(),
                          catId: selectedCategoryId,
                        );
                        await productController.saveData(Credentials.subcategoryCollectonId, newSubcategory.toJson());
                        // Clear the form
                        _titleController.text = "";
                        setState(() {
                          selectedCategoryId = null; // Reset dropdown value
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("upload successfull")),
                        );
                        // Navigator.pop(context); // Go back to the previous screen
                      } catch (e) {
                        EasyLoading.dismiss();
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
              SizedBox(height: 30.h),
              Container(
                alignment: Alignment.center,
                height: 95.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10.w);
                  },
                  itemCount: subcategories.length,
                  itemBuilder: (context, index) {
                    final subCategory = subcategories[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle category tap
                      },
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Column(
                            children: [
                              Text(
                                subCategory.title ?? "No Title",
                                style: CustomTextStyles.text12w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
