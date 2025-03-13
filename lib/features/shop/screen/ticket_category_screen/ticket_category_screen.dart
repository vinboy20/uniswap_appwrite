import 'package:flutter/material.dart';
import 'package:uniswap/common/widgets/form/custom_search_view.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/features/home/screens/home_container/widgets/drawer_widget.dart';

class TicketCategoryScreen extends StatelessWidget {
  const TicketCategoryScreen({super.key});

  // TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
         appBar: AppBar(
          title: Text(
            "Purchase History",
            style: CustomTextStyles.text14wbold,
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.notes_sharp), // Your custom icon
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          width: 271.w,
          child: DrawerWidget(),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
          child: Column(
            children: [
              CustomSearchView(
                // controller: searchController,
                autofocus: false,
                hintText: "Search",
                contentPadding: EdgeInsets.symmetric(vertical: 19.h),
              ),
              SizedBox(height: 24.h),
              _buildTicketContainer(context)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTicketContainer(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 39.h);
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: TImages.ticket,
                height: 85.h,
                width: 123.w,
                radius: BorderRadius.circular(
                  10.w,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 13.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The ProductCon",
                        style: CustomTextStyles.text14wbold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "By Mx media",
                        style: CustomTextStyles.text12wBold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "₦7,000",
                        style: CustomTextStyles.text12wBold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "July 20th, 8:00PM",
                        style: CustomTextStyles.text12w400.copyWith(color: TColors.gray200),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.adaptSize),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index == 0
                        ? const Color.fromARGB(255, 224, 219, 198)
                        : index == 1
                            ? const Color(0xFFEFFFFC)
                            : const Color.fromARGB(235, 239, 229, 229)),
                child: Text(
                  index == 0
                      ? "Pending"
                      : index == 1
                          ? "Received"
                          : "Cancelled",
                  style: TextStyle(
                      color: index == 0
                          ? const Color(0xFFD97706)
                          : index == 1
                              ? const Color(0xFF42D8B9)
                              : const Color(0xFFFB647A),
                      fontSize: 12.adaptSize),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
